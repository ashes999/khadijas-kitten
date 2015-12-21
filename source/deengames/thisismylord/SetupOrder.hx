package deengames.thisismylord;

import flixel.FlxG;
import flixel.FlxState;
import deengames.abook.Scene;
import deengames.thisismylord.scene.*;

class SetupOrder extends FlxState
{
  override public function create():Void
  {
    var scenes:Array<Class<Scene>> = [
      TitleScreen,
      TheEndScreen
    ];

    Scene.scenes = scenes;
    FlxG.switchState(new deengames.abook.SplashScreen());

    super.create();
  }

  /**
  * Function that is called when this state is destroyed - you might want to
  * consider setting all objects this state uses to null to help garbage collection.
  */
  override public function destroy():Void
  {
    super.destroy();
  }

  /**
  * Function that is called once every frame.
  */
  override public function update():Void
  {
    super.update();
  }
}
