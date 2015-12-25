package deengames.abook.core;

import flixel.FlxSprite;

using deengames.extensions.StringExtensions;

/**
A basic interactive element, it displays a static image (or the first frame of
an animation). When you click on it, it starts an animation (optional), and plays
an audio file (optional).
**/
class Element extends FlxSprite {

  public var imageFile(default, null) : String;

  public function withImage(imageFile : String) : Element
  {
    this.imageFile = imageFile.addExtension();
    this.loadGraphic(this.imageFile);
    return this;
  }

  public function at(x : Int, y : Int) : Element
  {
    this.x = x;
    this.y = y;
    return this;
  }
}
