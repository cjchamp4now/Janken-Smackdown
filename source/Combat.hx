package;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxG;

/**
 * ...
 * @author Cory Jackson
 */
class Combat extends FlxTypedGroup<FlxSprite>
{
	public var theEnemy:Enemy;
	public var playerHP(default, null):Int;
	public var outcome(default, null):Bool; 
	var wait:Bool = true;
	var background:FlxSprite;
	var enemySprite:Enemy;
	
	var _enemyHP:Int;
	
	var attack:Int;
	var enemyAttack:Int; //make random or set
	
	//var result:Bool;
	
	var attacksprite:FlxSprite;
	
	var pewpew:FlxText;
	//var screen:FlxSprite;
	
	public function new() 
	{
		super();
		
		background = new FlxSprite().makeGraphic(120, 120, FlxColor.RED);
		background.drawRect(1, 1, 118, 44, FlxColor.BLACK);
		background.drawRect(1, 46, 118, 73, FlxColor.BLACK);
		background.screenCenter();
		add(background); //basic black background with aborder
		
		//enemyimage
		enemySprite = new Enemy(background.x + 50, background.y + 50, 0); //change location x+y
		add(enemySprite);
		
		//enemyhealth
		//do you really need to actually know tho?
		enemyHP = 1; //change later in begin
		
		//attacks
		attacksprite = new FlxSprite(background.x + 75, background.y + 75);
		attacksprite.loadGraphic("assets/images/attacks.png", false, 100, 50);
		add(attacksprite);
		
		//TODO maybe add a indicator for damage or being damaged
		pewpew = new FlxText(background.x + 100, background.y + 100, 200, "", 16);
		pewpew.alignment = CENTER;
		pewpew.visible = false;
		add(pewpew);
		
		active = false;
		visible = false;
		
		//TODO load sound effects
		//soundHURT = FlxG.sound.load(AssetPaths.oof__wav);
	}
	
	
	/**
	 * 
	 * @param	playHP player health
	 * @param	En the enemy
	 */
	public function begin(playHP:Int, En:Enemy):Void
	{
		//screen.drawFrame();
		
		//playcombat musicz TODO
		
		playerHP = playHP;
		theEnemy = En;
		
		//update player health on screen TODO
		_enemyHP = ((En.enemytype % 2) + 1);
		enemySprite.changetypeofenemy(En.enemytype);
		
		wait = true;
		pewpew.text = "";
		pewpew.visible = false;
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (!wait)
		{
			var z:Bool = false; //rock
			var x:Bool = false; //paper
			var c:Bool = false; //scissors
			var v:Bool = false; //random
			
			//if(FlxG.keys.justPressed("Z")) TODO
		}
	}
	
}