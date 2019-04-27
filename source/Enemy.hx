package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

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
		loadGraphic("assets/images/enemy" + enemytype + ".jpg", false);
		
	}
	
	public function changetypeofenemy(Etype:Int):Void{
		if (enemytype != Etype){
			enemytype = Etype;
			//loadGraphic(); TODO
			loadGraphic("assets/images/enemy" + enemytype + ".jpg", false);
		}
	}
	
	
	
}