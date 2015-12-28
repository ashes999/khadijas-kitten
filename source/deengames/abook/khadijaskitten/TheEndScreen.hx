package deengames.abook.khadijaskitten;

import deengames.abook.core.Screen;

class TheEndScreen extends Screen
{
  override public function create():Void
  {
    super.create();
    this.addAndCenter('assets/images/restart');
  }
}
