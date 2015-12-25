package deengames.abook.core;

import flixel.FlxObject;
import flixel.FlxSprite;
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

  public function withImage(imageFile:String) : Element
  {
    this.imageFile = imageFile.addExtension();
    this.loadGraphic(this.imageFile);
    return this;
  }

  public function at(x:Int, y:Int) : Element
  {
    this.x = x;
    this.y = y;
    return this;
  }

  /**
  Don't use this with withImage. It overrides the image from withImage. Note that
  the animation resets to the first frame after completion.
  */
  public function withAnimation(spriteSheet:String, width:Int, height:Int, frames:Int, fps:Int) : Element
  {
    spriteSheet = spriteSheet.addExtension();
    this.animationFile = spriteSheet;
    this.loadGraphic(spriteSheet, true, width, height);
    var range = [for (i in 0 ... frames) i];
    range.push(0); // reset to first image on completion
    this.animation.add('main', range, fps, false); // false => no loop
    MouseEventManager.add(this, function(obj:FlxObject) {
      this.animation.play('main');
    });
    return this;
  }
}
