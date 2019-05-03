package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var health:Int = 4;
	var isCombat:Bool = false;
	var combatHud:Combat;
	var ending:Bool = false;
	var won:Bool;
	
	var map:FlxOgmoLoader;
	var Walls:FlxTilemap;
	var allEnemies:FlxTypedGroup<Enemy>;
	
	override public function create():Void
	{
		map = new FlxOgmoLoader("assets/data/map.oel");
		Walls = map.loadTilemap("assets/images/walltile.png", 16, 16, "walls");
		Walls.follow();
		Walls.setTileProperties(0, FlxObject.NONE);
		Walls.setTileProperties(1, FlxObject.ANY);
		//Walls.setTileProperties(3, FlxObject.ANY);
		add(Walls);
		
		allEnemies = new FlxTypedGroup<Enemy>();
		add(allEnemies);
		
		player = new Player();
		map.loadEntities(placeThings, "entities");
		add(player);
		
		combatHud = new Combat();
		add(combatHud);

		
		super.create();
		
		//var testenemy = new Enemy(0, 0, 99);
		//startCombat(testenemy);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		
		if (ending){
			return;
		}
		
		if (!isCombat){
			FlxG.collide(player, Walls);
			FlxG.overlap(player, allEnemies, playerTouchEnemy);
		} else {
			if (!combatHud.visible){
					health = combatHud.playerHP;
					if (combatHud.outcome == false){
						ending = true;
						//youlose TODO
						won = false;
						FlxG.switchState(new EndState(won));
						
					} else { //you win
						combatHud.theEnemy.kill();
						if (combatHud.theEnemy.enemytype == 99){ //killed a boss
							won = true;
							ending = true;
							FlxG.switchState(new EndState(won));
							//youwin TODO
						} else { //killed a not boss
							//idk confetti or something
							
						}
						isCombat = false;
						//make player and enmies active again
						player.active = true;
					}
			}
		}
	}
	
	function placeThings(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			player.x = x;
			player.y = y;
		} else if (entityName == "enemy"){
			allEnemies.add(new Enemy(x, y, Std.parseInt(entityData.get("etype"))));
		}
	}
	
	function playerTouchEnemy(Pl:Player, En:Enemy):Void
	{
		if (Pl.alive && Pl.exists && En.alive && En.exists)
		{
			startCombat(En);
		}
	}
	
	function startCombat(En:Enemy):Void
	{
		isCombat = true;
		player.active = false;
		combatHud.begin(health, En);
	}
	
	
	
}