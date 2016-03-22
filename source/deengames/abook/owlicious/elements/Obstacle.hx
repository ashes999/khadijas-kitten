package deengames.abook.owlicious.elements;

import deengames.abook.core.Element;
import flixel.input.mouse.FlxMouseEventManager;

class Obstacle extends Element
{
    public function new(json:Dynamic)
    {
        var type:String = json.type;
        
        super();
        this.loadGraphic('assets/images/${type}.png');
        this.enableMouseDrag();
        
        FlxMouseEventManager.add(this, this.onMouseDown, this.onMouseUp);
    }
    
    public function onMouseDown(me:Element):Void
    {
        this.startDrag();
    }
    
    public function onMouseUp(me:Element):Void
    {
        this.stopDrag();
    }
}