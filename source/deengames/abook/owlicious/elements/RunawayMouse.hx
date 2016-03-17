package deengames.abook.owlicious.elements;

import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxObject;
import deengames.abook.core.Element;

class RunawayMouse extends Element
{
    public function new(json:Dynamic)
    {
        super();
    }
    
    override private function clickHandler(obj:FlxObject):Void
    {
        super.clickHandler(obj);
        this.velocity.y += 100; // run off-screen. faster.
    }
}