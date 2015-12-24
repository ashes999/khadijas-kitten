package deengames.abook;

import ru.zzzzzzerg.linden.Flurry;

// static class
class FlurryWrapper {

  private static var screenStartTime:Float = 0;

  public static function startSession(flurryKey:String) : Void
  {
    Flurry.onStartSession(flurryKey);
  }

  public static function endSession() : Void
  {
    Flurry.onEndSession();
  }

  public static function logEvent(name:String, ?params:Dynamic = null) : Void
  {
    Flurry.logEvent(name, params);
  }

  public static function trackScreenStartTime() {
    screenStartTime = Date.now().getTime();
  }

  public static function trackScreenEndTime(screenName:String) {
    var screenEndTime:Float = Date.now().getTime();
    var elapsedSeconds = screenEndTime - screenStartTime;
    // ms granularity on Android
    elapsedSeconds = Math.round(elapsedSeconds / 1000);
    FlurryWrapper.logEvent('Viewed Screen', {
      'Screen': screenName, 'View Time (seconds)' : elapsedSeconds });

  }

}
