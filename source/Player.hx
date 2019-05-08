package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

/**
 * ...
 * @author Cory Jackson
 */
class Player extends FlxSprite 
{
	public var speed:Float = 150;
	var walk:FlxSound;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic("assets/images/player.jpeg", false, 16, 16);
		drag.x = drag.y = 1000;
		//maybe animation //nah
		setSize(8, 8);
		offset.set(6, 2);
		walk = FlxG.sound.load("assets/sounds/walk.wav");
	}
	
	function move():Void
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		
		if (up && down){ //add null movement later //nah
			up = down = false;
		}
		if (left && right){
			left = right = false;
		}
		
		if ( up || down || left || right){
			var mA:Float = 0;
			if (up){
				mA = -90;
				if (left){
					mA -= 45;
				} else if (right){
					mA += 45;
				}
			}else if (down){
				mA = 90;
				if (left){
					mA += 45;
				} else if (right){
					mA -= 45;
				}
			}else if (left){
				mA = 180;
			}else if (right){
				mA = 0;
			}
			
			velocity.set(speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), mA);
			
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
			{
				walk.play();
				//animation stuff //nah
			}
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		move();
		super.update(elapsed);
	}
}