package;
import flixel.FlxSprite;

/**
 * ...
 * @author Cory Jackson
 */
class Combat 
{
	public var theEnemy:Enemy;
	public var playerHP(default, null):Int;
	public var outcome(default, null):Outcome; 
	
	var background:FlxSprite;
	var enemySprite:Enemy;
	
	
	public function new() 
	{
		
	}
	
}