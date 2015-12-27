package deengames.abook.core;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.plugin.MouseEventManager;

using deengames.extensions.StringExtensions;

/**
A basic interactive element, it displays a static image (or the first frame of
an animation). When you click on it, it starts an animation (optional), and plays
an audio file (optional).
**/
class Element extends FlxSprite {

  public var imageFile(default, null) : String;
  public var animationFile(default, null) : String;
  private var clickAudioFile(default, null) : String;
  private var clickAudioSound:FlxSound;

  public function new() {
    super();
    MouseEventManager.add(this, clickHandler);
  }

  public function setImage(imageFile:String) : Void
  {
    this.imageFile = imageFile.addExtension();
    this.loadGraphic(this.imageFile);
  }

  /**
  Don't use this with withImage. It overrides the image from withImage. Note that
  the animation resets to the first frame after completion, and restarts on click.
  */
  public function setAnimation(spriteSheet:String, width:Int, height:Int, frames:Int, fps:Int) : Void
  {
    spriteSheet = spriteSheet.addExtension();
    this.animationFile = spriteSheet;
    this.loadGraphic(spriteSheet, true, width, height);
    var range = [for (i in 0 ... frames) i];
    range.push(0); // reset to first image on completion
    this.animation.add('main', range, fps, false); // false => no loop
  }

  /**
  Play an animation on click. Note that the audio restarts on click.
  */
  public function setClickAudio(fileName:String) : Void
  {
    this.clickAudioFile = fileName;
    this.clickAudioSound = FlxG.sound.load(this.clickAudioFile + deengames.io.AudioManager.SOUND_EXT);
  }

  // Centralize stuff we do on click
  private function clickHandler(obj:FlxObject) : Void
  {
    if (this.animation != null) {
      this.animation.pause();
      this.animation.play('main', true); // force restart
    }

    if (this.clickAudioSound != null) {
      this.clickAudioSound.stop();
      this.clickAudioSound.play(true); // force restart
    }
  }
}
