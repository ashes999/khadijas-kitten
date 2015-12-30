package deengames.abook.debug;

import deengames.abook.core.Screen;
import flixel.FlxG;

// static class
class GameJsonWatcher {
  public static function watchForChanges(relativeFileName:String)
  {
    #if neko
		#if debug
			// Don't watch the file in the bin dir; watch the source one. We get four
			// directories deep from source (export/linux64/neko/bin).
			new deengames.io.FileWatcher().watch('../../../../${relativeFileName}').onChange(function() {
				var currentScreenName = null;
				if (Screen.currentScreenData != null) {
					currentScreenName = Screen.currentScreenData.name;
          trace('WE WERE IN: ${currentScreenName}');
				}

				var json = sys.io.File.getContent('../../../../${relativeFileName}');
		    deengames.abook.ScreensJsonParser.parse(json);

				var found = false;
				for (data in Screen.screensData) {
					if (data.name == currentScreenName) {
            trace('FOUND: ${data.name}');
						Screen.transitionTo(Screen.createInstance(data));
						found = true;
						break;
					}
				}

				if (!found) {
          trace('NOT FOUND.');
					FlxG.switchState(new deengames.abook.boot.SplashScreen());
				}
			});
			deengames.io.DebugLogger.log("Watching source/assets/Game.json");
		#end
		#end
  }
}
