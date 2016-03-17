package deengames.abook.owlicious;

import deengames.abook.core.Screen;
import deengames.abook.core.Element;
import deengames.abook.owlicious.Cloud;

import Main;

class FlyingOutScreen extends Screen {
    
    private var clouds:Array<Cloud> = new Array<Cloud>();
        
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