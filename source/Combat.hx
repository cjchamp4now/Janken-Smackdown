package;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author Cory Jackson
 */
class Combat extends FlxTypedGroup<FlxSprite>
{
	public var theEnemy:Enemy;
	public var playerHP(default, null):Int;
	public var outcome(default, null):Bool; 
	
	var background:FlxSprite;
	var enemySprite:Enemy;
	
	var enemyHP:Int;
	
	var attack:Int;
	var enemyAttack:Int; //make random or set
	
	//var result:Bool;
	
	
	public function new() 
	{
		super();
		
		background = new FlxSprite().makeGraphic(120, 120, FlxColor.RED);
		background.drawRect(1, 1, 118, 44, FlxColor.BLACK);
		background.drawRect(1, 46, 118, 73, FlxColor.BLACK);
		background.screenCenter();
		add(background); //basic black background with aborder
		
		
	}
	
}