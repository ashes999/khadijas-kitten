package deengames.abook.core;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

import deengames.io.GestureManager;
import deengames.abook.controls.PlayAudioButton;

import deengames.analytics.FlurryWrapper;
import deengames.analytics.GoogleAnalyticsWrapper;

using StringTools;
using deengames.extensions.StringExtensions;

/**
 * The below block is for animated GIFs (yagp)
import com.yagp.GifDecoder;
import com.yagp.Gif;
import com.yagp.GifPlayer;
import com.yagp.GifPlayerWrapper;
import com.yagp.GifRenderer;
import openfl.Assets;
*/

/**
* A common base state used for all screens.
*/
class Screen extends FlxState
{
  /** To maintain statelessness, we keep an array of state data for each screen.
  We don't keep the screen instances, because that could be wierdly stateful.
  (If you want to keep state, use the Reg class, or some other mechanism.)
  We destroy/recreate scenes on demand, using the JSON data. */
  public static var screensData:Array<Dynamic> = new Array<Dynamic>();

  private var nextScreenData:Dynamic;
  private var previousScreenData:Dynamic;
  private var gestureManager:GestureManager = new GestureManager();
  private var playAudioButton:PlayAudioButton;
  private var data:Dynamic;

  private static inline var FADE_DURATION_SECONDS = 0.33;

  public function new(?data:Dynamic = null)
  {
    super();
    this.data = data;
  }

  /**
  * Function that is called up when to state is created to set it up.
  */
  override public function create() : Void
  {
    this.gestureManager.onGesture(Gesture.Swipe, onSwipe);

    if (data != null && data.audio != true) {
      this.hideAudioButton();
    } else {
      this.playAudioButton = new PlayAudioButton(this);
    }

    var next = Screen.getNextScreen(this);
    if (next != null) {
      this.nextScreenData = next;
    }

    var previous = Screen.getPreviousScreen(this);
    if (previous != null) {
      this.previousScreenData = previous;
    }

    super.create();

    // Process the JSON data, and create elements, set the background/audio, etc.
    this.processData();

    // Fade in
    FlxG.camera.flash(FlxColor.BLACK, FADE_DURATION_SECONDS);
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
    this.gestureManager.update();
    super.update();
  }

  // Used to start a new session. HaxeFlixel resumes on reopen.
  // Key duplicated in Main.main
  override public function onFocus() : Void
  {
    FlurryWrapper.startSession(Reg.flurryKey);
    GoogleAnalyticsWrapper.init(Reg.googleAnalyticsUrl);
    var name = "Unknown";
    if (this.data != null && this.data.name != null) {
      name = this.data.name;
    }
    FlurryWrapper.logEvent('Resume', { 'Screen': name });
  }

  /**
   * Called on Mobile when the app loses focus / switches out
   * NOTE: this won't fire if FlxG.autoPause = true. The last
   * release that needed this is 3.3.6. If you upgrade, we're cool.
   * See: https://github.com/HaxeFlixel/flixel/issues/1408#issuecomment-67769018
   */
  override public function onFocusLost() : Void
  {
    var name = "Unknown";
    if (this.data != null && this.data.name != null) {
      name = this.data.name;
    }
    FlurryWrapper.logEvent('Shutdown', { 'Final Screen': name });
    FlurryWrapper.endSession();
    super.onFocusLost();
  }

  private function processData() : Void
  {
    // Populate functionality based on data.
    if (this.data != null) {
      if (this.data.backgroundImage != null) {
        this.addAndCenter('assets/images/${this.data.backgroundImage}');
      }
      if (this.data.audio != null) {
        this.loadAndPlay('assets/audio/${this.data.audio}');
      }
      if (this.data.hideAudioButton == true) {
        this.hideAudioButton();
      }
    }
  }

  // Returns the data for the next sceen (which is enough to construct it)
  private static function getNextScreen(screen:Screen) : Dynamic
  {
    var datas = Screen.screensData;
    var arrayIndex = datas.indexOf(screen.data);
    if (arrayIndex > -1 && arrayIndex < datas.length - 1) {
      // Return the first screen with show != false
      for (i in (arrayIndex + 1)...datas.length) {
        if (datas[i].show != false) {
          return datas[i];
        }
      }
      // The rest are all show = false. There's no screen.
      return null;
    } else {
      return null;
    }
  }

  // Returns the data for the previous sceen (which is enough to construct it)
  private static function getPreviousScreen(screen:Screen) : Dynamic
  {
    var datas = Screen.screensData;
    var arrayIndex = datas.indexOf(screen.data);
    if (arrayIndex > 0) {
      // Return the first screen with show != false
      var i = arrayIndex - 1;
      while (i >= 0) {
        if (datas[i].show != false) {
          return datas[i];
        }
        i -= 1;
      }
      // The rest are all show = false. There's no screen.
      return null;
    } else {
      return null;
    }
  }

  public function addAndCenter(fileName:String) : FlxSprite
  {
    fileName = fileName.addExtension();
    var sprite = this.addSprite(fileName);
    centerOnScreen(sprite);
    return sprite;
  }

  private function addSprite(fileName:String) : FlxSprite
  {
    fileName = fileName.addExtension();
    var sprite = new FlxSprite();
    sprite.loadGraphic(fileName);
    add(sprite);
    return sprite;
  }

  private function addAndCenterAnimation(spriteSheet:String, width:Int, height:Int, frames:Int, fps:Int) : FlxSprite
  {
    spriteSheet = spriteSheet.addExtension();
    var sprite:FlxSprite = new FlxSprite();
    sprite.loadGraphic(spriteSheet, true, width, height);
    var range = [for (i in 0 ... frames) i];
    sprite.animation.add('loop', range, fps, true);
    sprite.animation.play('loop');
    add(sprite);
    centerOnScreen(sprite);
    return sprite;
  }

  // Requires YAGP
  /*
  private function addAndCenterAnimatedGif(file:String) : GifPlayerWrapper {
    var gif:Gif = GifDecoder.parseByteArray(Assets.getBytes(file));
    // Gif is null? Make sure in Project.xml, you specify *.gif as type=binary
    var player:GifPlayer = new GifPlayer(gif);
    var wrapper:GifPlayerWrapper = new GifPlayerWrapper(player);
    FlxG.addChildBelowMouse(wrapper);
    wrapper.x = (FlxG.width - wrapper.width) / 2;
    wrapper.y = (FlxG.height - wrapper.height) / 2;
    // wrapper.scaleX/scaleY
    return wrapper;
  }
  */

  private function scaleToFitNonUniform(sprite:FlxSprite) : Void
  {
    // scale to fit
    var scaleW = FlxG.width / sprite.width;
    var scaleH = FlxG.height / sprite.height;
    //  non-uniform scale
    sprite.scale.set(scaleW, scaleH);
  }

  private function scaleToFit(sprite:FlxSprite) : Void
  {
    var scaleW = FlxG.width / sprite.width;
    var scaleH = FlxG.height / sprite.height;
    var scale = Math.min(scaleW, scaleH);
    //  uniform scale
    sprite.scale.set(scale, scale);
  }

  private function centerOnScreen(sprite:FlxSprite) : Void
  {
    sprite.x = (FlxG.width - sprite.width) / 2;
    sprite.y = (FlxG.height - sprite.height) / 2;
  }

  private function onSwipe(direction:SwipeDirection) : Void
  {
    if (direction == SwipeDirection.Left && this.nextScreenData != null) {
      showNextScreen();
    } else if (direction == SwipeDirection.Right && this.previousScreenData != null) {
      showPreviousScreen();
    }
  }

  private function showNextScreen() : Void
  {
    logScreen(this.nextScreenData, 'Next');
    Screen.transitionTo(new Screen(this.nextScreenData));
  }

  private function showPreviousScreen() : Void
  {
    logScreen(this.previousScreenData, 'Previous');
    Screen.transitionTo(new Screen(this.previousScreenData));
  }

  public static function transitionTo(target:Screen) : Void
  {
    // 1/3s
    FlxG.camera.fade(FlxColor.BLACK, FADE_DURATION_SECONDS, false, function() {
      FlxG.switchState(target);
    });
  }

  /** s = screen data */
  private function logScreen(s:Dynamic, direction:String) {
    FlurryWrapper.logEvent('ShowScreen', { 'Screen': s.name, 'Direction': direction });
  }

  // Called from subclass screens
  private function loadAndPlay(file:String) : Void
  {
    if (this.playAudioButton == null) {
      this.playAudioButton = new PlayAudioButton(this);
    }
    this.playAudioButton.loadAndPlay(file);
  }

  private function hideAudioButton() : Void
  {
    if (this.playAudioButton != null) {
      this.playAudioButton.destroy();
    }
  }
}
