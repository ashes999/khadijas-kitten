package deengames.abook.boot;

import flixel.FlxG;
import deengames.abook.core.Screen;

// Runs after preloader.
// Loads JSON, sets up screens, goes to splash screen
class StartupScreen extends Screen {

  override public function create() : Void
  {
    // Load Game.json file
    // Parse and create screens
    // Populate them into Screen.screens
    var json = openfl.Assets.getText('assets/Game.json');
    var gameData:Dynamic = haxe.Json.parse(json);
    var screensData:Array<Dynamic> = cast(gameData.screens, Array<Dynamic>);

    var i = 0;
    for (data in screensData) {
      Screen.screensData.push(data);
    }

    FlxG.switchState(new deengames.abook.boot.SplashScreen());
  }

}
