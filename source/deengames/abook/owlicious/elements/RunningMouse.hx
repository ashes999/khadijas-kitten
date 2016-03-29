package deengames.abook.owlicious.elements;

import deengames.abook.core.Element;
import deengames.abook.core.Screen;

class RunningMouse extends Element
{
    private static inline var RUN_SPEED:Int = 200;
    
    public function new(x:Float, y:Float, runDirection:String)
    {
        super();
        this.setImage('assets/images/mouse-running-${runDirection}');
        this.x = x;
        this.y = y + 32;
        this.setClickAudio("assets/audio/mouse-squeak");        
        this.velocity.x = (runDirection == "left" ? -1 : 1) * RUN_SPEED;
        // +- 20% velocity
        var modifier = 1 + (Math.random() * 0.4) - 0.2;
        this.velocity.x *= modifier;
        this.velocity.y = Math.random() * 50;
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (this.x < -this.width || this.x > Main.gameWidth || this.y >= Main.gameHeight)
        {
            // Notify the owl that we got away
            for (e in Screen.currentScreen.elements)
            {
                if (Std.is(e, HuntingOwl))
                {
                    var owl:HuntingOwl = cast(e, HuntingOwl);
                    owl.gotAway(this);
                    break;
                }
            }
            
            Screen.currentScreen.remove(this);
            Screen.currentScreen.elements.remove(this);
            this.destroy();
        }
    }
}