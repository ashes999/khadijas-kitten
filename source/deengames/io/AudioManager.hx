package deengames.io;

import flixel.system.FlxSound;
import flixel.FlxG;

class AudioManager {
  public static inline var SOUND_EXT:String = #if flash ".mp3" #else ".ogg" #end ;

  private function new() { } // static class

  public static function play(name:String, pitch:Float = 1.0) : Void {
    var sound:FlxSound = FlxG.sound.load(name + SOUND_EXT);
    sound.pitch = pitch;
    sound.play();
  }
}
