package deengames.abook.controls;

import flixel.system.FlxSound;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.plugin.MouseEventManager;

import deengames.abook.core.Screen;

class PlayAudioButton {
  private var audio:FlxSound;
  private var buttonSprite:FlxSprite;

  public function new(screen:Screen) {
    this.buttonSprite = screen.addAndCenter('assets/images/play-sound.png');
    buttonSprite.x = FlxG.width - buttonSprite.width - 32;
    buttonSprite.y = FlxG.height - buttonSprite.height - 32;
    MouseEventManager.add(buttonSprite, null, function(sprite:FlxSprite) {
      this.play();
    });
  }

  public function destroy() : Void {
    if (this.buttonSprite != null) {
      this.buttonSprite.destroy();
    }
  }

  public function play() : Void {
    if (this.audio != null) {
      this.audio.stop();
      this.audio.play(true); // force restart
    }
  }

  public function loadAndPlay(file:String):Void {
    if (this.audio != null) {
      this.audio.stop();
    }

    this.audio = FlxG.sound.load(file + deengames.io.AudioManager.SOUND_EXT);
    this.audio.play(true);
  }
}
