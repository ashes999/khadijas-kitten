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
			new deengames.io.FileWatcher().watch('../../../../${relativeFileName}')
      .continueOnError().pollTime(0.167) // 60FPS, mmhmm...
      .onChange(function() {
				var currentScreenName = null;
				if (Screen.currentScreenData != null) {
					currentScreenName = Screen.currentScreenData.name;
				}

				var json = sys.io.File.getContent('../../../../${relativeFileName}');
		    deengames.abook.ScreensJsonParser.parse(json);

				var found = false;
				for (data in Screen.screensData) {
					if (data.name == currentScreenName) {
            FlxG.switchState(Screen.createInstance(data));
						found = true;
						break;
					}
				}

				if (!found) {
          deengames.io.DebugLogger.log('Could not find existing screen (name=${currentScreenName}) in ${relativeFileName}. Restarting.');
					var firstScreen = Screen.createInstance(Screen.screensData[0]);
          // Don't just switch screens; note what screen we're on.
          Screen.transitionTo(firstScreen);
				}
			});
			deengames.io.DebugLogger.log("Watching source/assets/Game.json");
		#end
		#end
  }
}
