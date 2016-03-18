package deengames.abook.owlicious.elements;

import flixel.math.FlxPoint;
import deengames.io.AudioManager;
import deengames.abook.core.Element;
import deengames.abook.core.Screen;

class OwlPellet extends Element
{
    private var stopX:Float;
    private var stopY:Float;
    
    public function new(owl:Element)
    {
        super();
        
        this.setImage('assets/images/owl-pellet');
        this.setClickAudio('assets/audio/speech-owl-pellet-info');
        
        this.x = owl.x + (owl.width - this.width) / 2;
        this.y = owl.y + owl.height - this.height;
        

        this.stopX = this.x - 300;
        this.stopY = this.y + 100;
        
        // Double the distance to travel => 0.5s travel time
        this.velocity = new FlxPoint(-600, 200);
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (this.x <= this.stopX && this.y >= this.stopY && this.velocity.y > 0)
        {
            // Snap to the correct position so they all line up
            this.x = this.stopX;
            this.y = this.stopY;
            this.velocity = new FlxPoint(0, 0);
        }
    }
}