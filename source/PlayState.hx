package;

import flixel.FlxState;

class PlayState extends FlxState
{
	var player:Player;
	var health:Int = 4;
	var isCombat:Bool = false;
	var combatHud:Combat;
	var ending:Bool;
	var won:Bool;
	
	
	
	override public function create():Void
	{
		combatHud = new Combat();
		add(combatHud);
		super.create();
		
		player = new Player(0, 0);
		var testenemy = new Enemy(0, 0, 99);
		startCombat(testenemy);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (!isCombat){
			//FlxG.collide();
		} else {
			if (!combatHud.visible){
					health = combatHud.playerHP;
					if (combatHud.outcome == false){
						ending = true;
						//youlose TODO
					} else { //you win
						combatHud.theEnemy.kill();
						if (combatHud.theEnemy.enemytype == 99){ //killed a boss
							won = true;
							ending = true;
							//youwin TODO
						} else { //killed a not boss
							//idk confetti or something
							
						}
					}
					isCombat = false; //alive or dead, we are out of combat
			}
		}
	}
	
	public function placeThings(entityName:String):Void
	{
		
	}
	
	function playerTouchEnemy(Pl:Player, En:Enemy):Void
	{
		startCombat(En);
	}
	
	function startCombat(En:Enemy):Void
	{
		isCombat = true;
		player.active = false;
		combatHud.begin(health, En);
	}
	
}