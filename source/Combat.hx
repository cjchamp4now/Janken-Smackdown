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
	var enemyAttack:Int;
	var attacksprite:FlxSprite;
	
	var pewpew:FlxText;
	var pewpart1:String;
	var pewpart2:String;
	var pewpart3:String;
	
	var healths:FlxText;
	
	var oof:FlxSound;
	var ouch:FlxSound;
	var tink:FlxSound;
	
	public function new() 
	{
		super();
		
		//enemyimage
		enemySprite = new Enemy(0, 0, 0); //change location x+y
		enemySprite.screenCenter();
		add(enemySprite);
		
		enemyHP = 1; //change later in begin
		
		//attacks
		attacksprite = new FlxSprite(0, 0);
		attacksprite.loadGraphic("assets/images/attacks.jpeg", false, FlxG.width, FlxG.height);
		attacksprite.screenCenter();
		add(attacksprite);
		
		//TODO maybe add a indicator for damage or being damaged
		pewpew = new FlxText((FlxG.width / 4), 0, (FlxG.width / 2), "", 16);
		pewpew.color = FlxColor.RED;
		pewpew.alignment = CENTER;
		pewpew.visible = false;
		add(pewpew);
		
		healths = new FlxText(0, 0, (FlxG.width / 4), "", 16);
		healths.color = FlxColor.PINK;
		healths.alignment = CENTER;
		add(healths);
		
		oof = FlxG.sound.load("assets/sounds/oof.wav");
		ouch = FlxG.sound.load("assets/sounds/ouch.wav");
		tink = FlxG.sound.load("assets/sounds/tink.wav");
		
		active = false;
		visible = false;
	}
	
	/**
	 * 
	 * @param	playHP player health
	 * @param	En the enemy
	 */
	public function begin(playHP:Int, En:Enemy):Void
	{
		playerHP = playHP;
		theEnemy = En;
		
		//update player health on screen TODO
		enemyHP = ((En.enemytype % 2) + 1);
		enemySprite.changetypeofenemy(En.enemytype);
		enemySprite.screenCenter();
		
		wait = true;
		pewpew.text = "";
		pewpew.visible = false;
		
		healths.text = "Player: " + playerHP + ", enemy: " + enemyHP;
		
		visible = true;
		active = true;
		wait = false;
	}
	
	function activatecombat(_):Void
	{
		active = true;
		wait = false;
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
			if (FlxG.keys.anyJustReleased([Z, ONE])) //rock
			{
				attack(0);
			}
			else if (FlxG.keys.anyJustReleased([X, TWO])) //paper
			{
				attack(1);
			}
			else if (FlxG.keys.anyJustReleased([C, THREE]))
			{
				attack(2);
			} 
			else if (FlxG.keys.anyJustReleased([V, FOUR])) //random
			{ 
				attack(3);
			}
		}
		super.update(elapsed);
	}
	
	function displayDamage(play:Int, enem:Int, res:Int):Void
	{
		if (play == 0){ //rock
			pewpart1 = "rock";
		} else if(play == 1) { //paper
			pewpart1 = "paper";
		} else{ //sc
			pewpart1 = "scissors";
		}
		
		if (enem == 0){ //rock
			pewpart2 = "rock";
		} else if(enem == 1) { //paper
			pewpart2 = "paper";
		} else{ //sc
			pewpart2 = "scissors";
		}
		
		if (res == 0){ //lost
			pewpart3 = "Player lost!";
		} else if(res == 1) { //won
			pewpart3 = "Player Won!";
		} else{ //draw
			pewpart3 = "Draw!";
		}
		
		pewpew.text = "Player did: " + pewpart1 + ", enemy did: " + pewpart2 + ". Result: " + pewpart3;
		pewpew.visible = true;
		healths.text = "Player: " + playerHP + ", enemy: " + enemyHP;
	}
	
	function playerHit(play:Int, enem:Int):Void
	{
		playerHP--;
		oof.play();
		displayDamage(play, enem, 0);
	}
	
	function enemyHit(play:Int, enem:Int):Void
	{
		enemyHP--;
		ouch.play();
		displayDamage(play, enem, 1);
	}
	
	function drawAttack(play:Int, enem:Int):Void
	{
		tink.play();
		displayDamage(play, enem, 2);
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
					playerHit(select, enemyattack);
				} else if (enemyattack == 2){ //rock vs scis player wins
					enemyHit(select, enemyattack);
				} else { //draw
					drawAttack(select, enemyattack);
				}
			
			case 1:
				if (enemyattack == 2){ //paper vs scis enemy wins
					playerHit(select, enemyattack);
				} else if (enemyattack == 0){ //paper vs rock player wins
					enemyHit(select, enemyattack);
				} else { //draw
					drawAttack(select, enemyattack);
				}
				
			case 2:
				if (enemyattack == 0){ //rock vs scis enemy wins
					playerHit(select, enemyattack);
				} else if (enemyattack == 1){ //paper vs scis player wins
					enemyHit(select, enemyattack);
				} else { //draw
					drawAttack(select, enemyattack);
				}
		}
		
		wait = true;
		if (playerHP <= 0){
			playerDed();
		} else if (enemyHP <= 0){
			enemyDed();
		} else {
			wait = false;
		}
	}
	
	function playerDed():Void
	{
		outcome = false;
		//end combat
		this.visible = false;
	}
	
	function enemyDed():Void
	{
		outcome = true;
		//end combat
		this.visible = false;
	}
}