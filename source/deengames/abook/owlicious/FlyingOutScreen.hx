package deengames.abook.owlicious;

import flixel.FlxSprite;
import deengames.abook.core.Screen;
import Main;

class FlyingOutScreen extends Screen {
    
    private var clouds:Array<FlxSprite> = new Array<FlxSprite>();
    
    override public function create():Void
    {
        super.create();
        
        // 1x 64, 2x 128, 1x 256
        this.clouds.push(new Cloud(64));        
        this.clouds.push(new Cloud(128));        
        this.clouds.push(new Cloud(128));        
        this.clouds.push(new Cloud(256));
        
        for (cloud in clouds) {
            add(cloud);
        }    
    }
    
    override public function update(elapsed:Float):Void
    {
        for (cloud in this.clouds) {
            cloud.update(elapsed);            
        }
    }
}

class Cloud extends FlxSprite
{
    public function new(size:Int)
    {
        super();
        this.loadGraphic('assets/images/cloud-${size}.png');
        this.resetPosition();
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
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
        this.velocity.x = -1 * ((Math.random() * 500) + 300); // 300-800
    }
}