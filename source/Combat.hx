package;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

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
	var enemySprite:Enemy;
	
	var enemyHP:Int;
	
	var enemyAttack:Int; //make random or set
	
	//var result:Bool;
	
	var attacksprite:FlxSprite;
	
	var pewpew:FlxText;
	//var screen:FlxSprite;
	
	
	var oof:FlxSound;
	
	public function new() 
	{
		super();
		
		//enemyimage
		enemySprite = new Enemy(0, 0, 0); //change location x+y
		enemySprite.screenCenter();
		add(enemySprite);
		
		//enemyhealth
		//do you really need to actually know tho?
		enemyHP = 1; //change later in begin
		
		//attacks
		attacksprite = new FlxSprite(0, 0);
		attacksprite.loadGraphic("assets/images/attacks.jpeg", false, 100, 50);
		attacksprite.screenCenter();
		add(attacksprite);
		
		//TODO maybe add a indicator for damage or being damaged
		pewpew = new FlxText(0, 0, 200, "", 16);
		pewpew.color = FlxColor.BROWN;
		pewpew.alignment = CENTER;
		pewpew.visible = false;
		add(pewpew);
		
		oof = FlxG.sound.load("assets/sounds/oof.wav");
		
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
		enemyHP = ((En.enemytype % 2) + 2);
		enemySprite.changetypeofenemy(En.enemytype);
		
		wait = true;
		pewpew.text = "";
		pewpew.visible = false;
		
		visible = true;
		active = true;
		wait = false;
		
	}
	
	function activatecombat(_):Void
	{
		active = true;
		wait = false;
		//begin battle music
	}
	
	function endcombat(_):Void
	{
		active = false;
		visible = false;
	}
	
	override public function update(elapsed:Float):Void
	{
		if (!wait)
		{
			var rock:Bool = false; //rock
			var paper:Bool = false; //paper
			var scissor:Bool = false; //scissors
			var random:Bool = false; //random
			
			//if(FlxG.keys.justPressed("Z")) TODO
			if (FlxG.keys.anyJustReleased([Z, ONE]))
			{
				rock = true;
			}
			else if (FlxG.keys.anyJustReleased([X, TWO]))
			{
				paper = true;
			}
			else if (FlxG.keys.anyJustReleased([C, THREE]))
			{
				scissor = true;
			} 
			else if (FlxG.keys.anyJustReleased([V, FOUR])){
				random = true;
			}
			
			if (rock){
				attack(0);
			} else if (paper){
				attack(1);
			} else if (scissor){
				attack(2);
			} else if (random){
				attack(3);
			}
			
		}
		super.update(elapsed);
	}
	
	function attack(select:Int):Void
	{
		var enemyattack:Int;
		enemyattack = FlxG.random.int(0, 2);
		if (select == 3){
			select = FlxG.random.int(0, 2);
		}
		switch(select)
		{
			case 0:
				if (enemyattack == 1){ //rock vs paper enemy wins
					playerHP--;
				} else if (enemyattack == 2){ //rock vs scis player wins
					enemyHP--;
				} else { //draw
					//play dud sound
				}
			
			case 1:
				if (enemyattack == 2){ //paper vs scis enemy wins
					playerHP--;
				} else if (enemyattack == 0){ //paper vs rock player wins
					enemyHP--;
				} else { //draw
					//play dud sound
				}
				
			case 2:
				if (enemyattack == 0){ //rock vs scis enemy wins
					playerHP--;
				} else if (enemyattack == 1){ //paper vs scis player wins
					enemyHP--;
				} else { //draw
					//play dud sound
				}
		}
		
		oof.play();
		
		wait = true;
		if (playerHP <= 0){
			//death sound
			pewpew.text = "Ded";
			pewpew.visible = true;
			outcome = false;
			//end combat
			this.visible = false;
		} else if (enemyHP <= 0){
			//enemy death sound
			pewpew.text = "Win";
			pewpew.visible = true;
			outcome = true;
			//end combat
			this.visible = false;
		} else {
			wait = false;
		}
	}
	
	
}