package deengames.abook.owlicious;

import deengames.abook.core.Screen;
import deengames.abook.core.Element;

import Main;

class FlyingOutScreen extends Screen {
    
    private var clouds:Array<Cloud> = new Array<Cloud>();
    
    override public function create():Void
    {
        super.create();
        
        this.clouds.push(new Cloud(256));        
        this.clouds.push(new Cloud(256));
        this.clouds.push(new Cloud(128));        
        this.clouds.push(new Cloud(128));        
        
        for (cloud in clouds) {
            add(cloud);
            this.elements.push(cloud);
        }       
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        for (cloud in this.clouds) {
            cloud.update(elapsed);
            if (cloud.zChanged == true)
            {
                this.sortElementsByZ();
            }         
        }
    }
}

class Cloud extends Element
{
    public var zChanged(default, null):Bool = false;
    
    public function new(size:Int)
    {
        super();
        this.loadGraphic('assets/images/cloud-${size}.png');
        this.resetPosition();
        this.x = Math.random() * Main.gameWidth; // Initially, not all at RHS
        
        this.setClickAudio('assets/audio/bubble-pop');
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        this.zChanged = false;
        if (this.x <= -this.width) {
            this.resetPosition();
        }
    }
    
    public function resetPosition():Void
    {
        // respawn on RHS of screen
        this.x = Main.gameWidth;
        // Randomize y
        this.y = Math.random() * (Main.gameHeight - this.height);
        this.velocity.x = -1 * ((Math.random() * 200) + 300); // 200-500
        // Owl's z is 5, so half clouds are over and half are under
        // 0...10
        this.z = Math.round((Math.random() * 10));
        this.zChanged = true;
        // Reset if popped
        this.alpha = 1;
    }
    
    override private function clickHandler(object:flixel.FlxObject):Void
    {
        super.clickHandler(object);
        this.alpha = 0;
    }
}