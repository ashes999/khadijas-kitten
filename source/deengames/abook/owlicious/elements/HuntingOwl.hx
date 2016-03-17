package deengames.abook.owlicious.elements;

import flixel.FlxObject;

import deengames.abook.core.Element;
import deengames.abook.core.Screen;

class HuntingOwl extends Element
{
    private static inline var MOVE_SPEED:Int = 50;
    
    private var currentPrey:HidingMouse;
    private var roostX:Float;
    private var roostY:Float;
    private var size:Int;
    
    public function new(json:Dynamic)
    {
        super();        
    }
    
    override public function create()
    {
        super.create();
        
        this.roostX = this.x;
        this.roostY = this.y;
        // Approximate size is sqrt[(width^2) + height(^2)]
        // If the mouse is this far away, we got him.
        this.size = Math.round(Math.sqrt(Math.pow(this.width, 2) + Math.pow(this.height, 2)));
    }
    
    override public function update(elapsed:Float):Void
    {        
        super.update(elapsed);
        if (currentPrey == null)
        {
            // Find a mouse to prey on
            for (member in Screen.currentScreen.members)
            {
                if (Std.is(member, HidingMouse))
                {
                    var mouse:HidingMouse = cast(member, HidingMouse);
                    currentPrey = mouse;
                    break;
                }
            }
        }
        
        // Looped through (now or previously) and found one
        if (currentPrey != null)
        {
            if (Math.abs(this.x - currentPrey.x) + Math.abs(this.y - currentPrey.y) <= this.size)
            {
                // Gotcha!
                // Play squeak noise
                currentPrey.destroy();
                currentPrey = null;
            }
            else
            {
                // Swoop down on that dude
                this.target(currentPrey.x, currentPrey.y);
            }
        } 
        else
        {
            // Back to the roosting grounds
            this.target(roostX, roostY);
        }
    }
    
    private function target(targetX:Float, targetY:Float):Void
    {
        // If we're too close, don't jitter, just chill.
        if (Math.abs(this.x - targetX) + Math.abs(this.y - targetY) <= 50)
        {
            this.velocity.x = 0;
            this.velocity.y = 0;
        }
        else
        {
            // Move toward it naively. This is not a constant velocity
            // (we move faster on diagonals).
            var vx:Int = this.x < targetX ? MOVE_SPEED : -MOVE_SPEED;
            var vy:Int = this.y < targetY ? MOVE_SPEED : -MOVE_SPEED;
            this.velocity.x = vx;
            this.velocity.y = vy;
        }
    }
}