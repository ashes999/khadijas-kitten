package deengames.abook.owlicious.elements;

import flixel.addons.display.FlxExtendedSprite;
import flixel.input.mouse.FlxMouseEventManager;
import deengames.abook.core.Screen;

class Obstacle extends FlxExtendedSprite
{
    public function new(json:Dynamic)
    {
        var type:String = json.type;
        
        super();
        this.loadGraphic('assets/images/${type}.png');
        this.enableMouseDrag();
        
        var screen:Screen = Screen.currentScreen;
        screen.add(this);
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