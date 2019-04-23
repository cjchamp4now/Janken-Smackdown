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
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	public function placeThings(entityName:String):Void
	{
		
	}
}