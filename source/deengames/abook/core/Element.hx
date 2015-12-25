package deengames.abook.core;

/**
A basic interactive element, it displays a static image (or the first frame of
an animation). When you click on it, it starts an animation (optional), and plays
an audio file (optional).
**/
class Element {

  public var x(default, default):Int;
  public var y(default, default):Int;

  public function new(x:Int, y:Int) {
    this.x = x;
    this.y = y;
  }
}
