package deengames.abook;

import deengames.abook.core.Screen;

/**
What we tried, but didn't work, to keep the class around:
@:keep (on this class)
<haxeflag name="-dce no" /> (project.xml)
<haxeflag name="-dce" value="no" />  (project.xml)
TODO: investigate further. For now, just create an instance of this somewhere
(eg. SplasScreen.hx's create method).
*/
class TheEndScreen extends Screen
{
  override public function create():Void
  {
    this.addAndCenter('assets/images/credits-bg.jpg');
  }
}
