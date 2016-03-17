package deengames.abook.owlicious.elements;

import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxObject;

import deengames.abook.core.Element;
import deengames.abook.core.Screen;

class RunawayMouse extends Element
{
    public function new(json:Dynamic)
    {
        super();
    }
    
    override public function update(elapsed:Float):Void
    {        
        super.update(elapsed);
        for (member in Screen.currentScreen.members)
        {
            if (Std.is(member, RunawayMouse))
            {
                var mouse:RunawayMouse = cast(member, RunawayMouse);
                if (mouse.y > Main.gameHeight)
                {
                    mouse.destroy();
                }
            }
        }
    }
    
    override private function clickHandler(obj:FlxObject):Void
    {
        super.clickHandler(obj);
        this.velocity.y += 100; // run off-screen. faster.
    }    
}