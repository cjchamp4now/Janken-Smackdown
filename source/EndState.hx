package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

/**
 * ...
 * @author Cory Jackson
 */
class EndState extends FlxState 
{
	var didWin:Bool;
	var finalImage:FlxSprite;
	var finalMessage:FlxText;
	
	
	public function new(Result:Bool) 
	{
		didWin = Result;
		super();
	}
	
	override public function create():Void 
	{
		FlxG.mouse.visible = false;
		finalImage = new FlxSprite(0, 0);
		if (didWin){
			finalImage.loadGraphic("assets/images/win.jpg");
			finalMessage = new FlxText(0, 0, 16, "You won!", 24);
			
		} else {
			finalImage.loadGraphic("assets/images/lose.jpg");
			finalMessage = new FlxText(0, 0, 16, "You lost~", 24);
		}
		finalImage.screenCenter();
		finalMessage.alignment = CENTER;
		finalMessage.screenCenter();
		add(finalImage);
		add(finalMessage);
		
		
	}
}