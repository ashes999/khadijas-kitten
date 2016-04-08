package deengames.abook.owlicious.elements;

import deengames.abook.core.Element;
import flixel.input.mouse.FlxMouseEventManager;

class Obstacle extends Element
{
    // Movable rock or bush
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
        // 0.8-1.2
        var pitch:Float = 0.8 + (Math.random() * 0.4);
        this.setAudioPitch(pitch);
        
        // Execute audio
        this.clickHandler(null);
        this.startDrag();
    }
    
    public function onMouseUp(me:Element):Void
    {
        this.stopDrag();
    }
}