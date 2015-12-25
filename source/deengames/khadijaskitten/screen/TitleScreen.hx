package deengames.khadijaskitten.screen;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;

import deengames.io.GestureManager;
import deengames.io.AudioManager;
import deengames.abook.core.Screen;
import deengames.abook.core.Element;
import deengames.khadijaskitten.screen.CreditsScreen;


class TitleScreen extends Screen
{
  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create():Void
  {
    var title:FlxSprite = this.addAndCenter('assets/images/titlescreen.png');
    this.loadAndPlay('assets/audio/giggle');
    //this.hideAudioButton();

    /*var creditsButton = this.addAndCenter('assets/images/credits.png');
    creditsButton.x = 64;
    creditsButton.y = FlxG.height - creditsButton.height - 96;
    MouseEventManager.add(creditsButton, null, clickedCreditsButton);*/

    // works, but characters appear left-to-right and broken up
    var text = new FlxText(16, 16);
    text.setFormat("assets/arabic.ttf", 48, FlxColor.WHITE);
    text.text = "بِسْمِ اللَّه الرَّحْمَانِ الرَّحِيمِ";
    add(text);

    super.create();

    add(new Element().withImage('assets/images/house').at(64, 32)
      .withAnimation('assets/images/monkey_helmet', 50, 55, 8, 8));
  }

  private function clickedCreditsButton(sprite:FlxSprite) : Void {
    FlxG.switchState(new CreditsScreen());
  }

  /**
  * Function that is called when this state is destroyed - you might want to
  * consider setting all objects this state uses to null to help garbage collection.
  */
  override public function destroy():Void
  {
    super.destroy();
  }

  /**
  * Function that is called once every frame.
  */
  override public function update():Void
  {
    super.update();
  }
}
