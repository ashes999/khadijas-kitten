package;

import flixel.util.FlxSave;

class Reg
{
	public static var flurryKey = 'INSERT FLURRY KEY HERE';
	public static var googleAnalyticsUrl = '/stats/khadijas-kitten.html';

	// 0 if we already finished viewing all the scenes; set to
	// Date.now().getTime() on first scene.
	public static var sawFirstScene:Float = 0;
}
