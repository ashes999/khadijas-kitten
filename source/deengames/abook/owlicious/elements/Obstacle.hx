package deengames.abook.owlicious.elements;

import flixel.addons.display.FlxExtendedSprite;
import flixel.input.mouse.FlxMouseEventManager;

class Obstacle extends FlxExtendedSprite
{
    public function new(json:Dynamic)
    {
        var type:String = json.type;
        
        super();
        this.loadGraphic('assets/images/${type}.png');
        this.enableMouseDrag();
        
        FlxMouseEventManager.add(this, this.onMouseDown, this.onMouseUp);
    }
    
    public function onMouseDown(me:FlxExtendedSprite):Void
    {
        this.startDrag();
    }
    
    public function onMouseUp(me:FlxExtendedSprite):Void
    {
        this.stopDrag();
    }
}