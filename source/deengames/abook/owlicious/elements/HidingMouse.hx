package deengames.abook.owlicious.elements;

import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxObject;

import deengames.abook.core.Element;
import deengames.abook.core.Screen;

class HidingMouse extends Element
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
            if (Std.is(member, HidingMouse))
            {
                var mouse:HidingMouse = cast(member, HidingMouse);
                if (mouse.y > Main.gameHeight)
                {
                    mouse.destroy();
                }
            }
        }
    }
    
    override public function clickHandler(obj:FlxObject):Void
    {
        // 0.8-1.2
        var pitch:Float = 0.8 + (Math.random() * 0.4);
        this.setAudioPitch(pitch);
        super.clickHandler(obj);
        this.velocity.y += 100; // run off-screen. faster.
    }    
}