package deengames.abook.boot;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxSprite;
import deengames.abook.core.Screen;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;
import deengames.io.GestureManager;

// Loads from startup screen.
class SplashScreen extends Screen
{
  private var startTime:Float = 0;

  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    super.create();
    this.hideAudioButton();

    var title:FlxSprite = this.addAndCenter('assets/images/dg-logo');
    this.loadAndPlay('assets/audio/giggle');

    startTime = Date.now().getTime();

    deengames.io.DebugLogger.log("@@@ DEBUG MODE ENABLED @@@");
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
    // Wait 3s + 0.5s fade-in, then fade out
    if (startTime > 0 && Date.now().getTime() - startTime >= 3500) {
      startTime = 0; // Execute this block only once
      // Fade out over 0.5s
      FlxG.camera.fade(FlxColor.BLACK, 1
        , false,function() {
        var instance = Screen.createInstance(Screen.screensData[0]);
        FlxG.switchState(instance);
      });
    }
    super.update();
  }

  override private function onSwipe(direction:SwipeDirection) : Void
  {
    // Do nothing
  }
}
