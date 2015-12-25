package deengames.abook.core;

import flixel.FlxG;
import deengames.abook.core.Screen;

// Loads JSON, sets up screens, goes to splash screen
class StartupScreen extends Screen {

  override public function create() : Void
  {
    // Load Game.json file
    // Parse and create screens
    // Populate them into Screen.screens
    var json = openfl.Assets.getText('assets/Game.json');
    var gameData = haxe.Json.parse(json);
    var screens = cast(gameData.screens, Array<Dynamic>);
    var i = 0;
    for (screen in screens) {
      var s = new Screen(screen);
      Screen.screens.push(s);
    }

    FlxG.switchState(new deengames.abook.SplashScreen());
  }

}
