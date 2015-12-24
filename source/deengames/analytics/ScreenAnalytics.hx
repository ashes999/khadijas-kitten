package deengames.abook.analytics;

// static class. Encapsulates analytics stuff for screens.
class ScreenAnalytics {

    private static var screenStartTime:Float = 0;

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
