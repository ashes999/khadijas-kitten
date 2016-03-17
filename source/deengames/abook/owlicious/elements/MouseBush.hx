package deengames.abook.owlicious.elements;

import flixel.FlxObject;

import deengames.io.AudioManager;
import deengames.abook.core.Element;
import deengames.abook.core.Screen;

class MouseBush extends Element
{
    private var runDirection:String;
    
    public function new(json:Dynamic)
    {
        super();
    }
    
    override public function clickHandler(obj:FlxObject):Void
    {
        var direction = (Math.round(Math.random() * 100) % 2) == 0 ? "left" : "right";
        // Play audio on a separate thread
        AudioManager.play(this.clickAudioFile);
        var screen:Screen = Screen.currentScreen;
        var yModifier = Math.random() * 32;
        var m = new RunningMouse(this.x, this.y + yModifier, direction);
        screen.add(m);
        screen.elements.push(m);
    }    
}