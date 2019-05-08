package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;

/**
 * ...
 * @author Cory Jackson
 */
class EndState extends FlxState 
{
	var didWin:Bool;
	var finalImage:FlxSprite;
	
	var finalsound:FlxSound;
	
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
			finalImage.loadGraphic("assets/images/win.jpg", false, FlxG.width, FlxG.height);
			finalsound = FlxG.sound.load("assets/sounds/win.wav");
			finalsound.play();
		} else {
			finalImage.loadGraphic("assets/images/lose.jpg", false, FlxG.width, FlxG.height);
			finalsound = FlxG.sound.load("assets/sounds/lose.wav");
			finalsound.play();
		}
		finalImage.screenCenter();
		add(finalImage);
	}
}