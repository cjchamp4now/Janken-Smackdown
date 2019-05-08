package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Cory Jackson
 */
class Enemy extends FlxSprite 
{
	public var enemytype(default, null):Int;
	
	public function new(?X:Float=0, ?Y:Float=0, Etype:Int) 
	{
		super(X, Y);
		enemytype = Etype;
		loadGraphic("assets/images/enemysprite" + enemytype + ".jpg", false, 16, 16);
	}
	
	public function changetypeofenemy(Etype:Int):Void{
			enemytype = Etype;
			//loadGraphic(); TODO
			loadGraphic("assets/images/enemy" + enemytype + ".jpg", false, FlxG.width, FlxG.height);
	}
}