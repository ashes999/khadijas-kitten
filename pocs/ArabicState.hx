/// A proof-of-concept that shows Arabic text and captures the word you clicked.
// It works by creating an invisible FlxSprite behind the text. MouseEventManager
// doesn't seem to like FlxText objects. This is better, because we don't want
// pixel-perflect clicks on text (we want bounding-box clicks).
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import flixel.plugin.MouseEventManager;
using flixel.util.FlxSpriteUtil;
using StringTools;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class ArabicState extends FlxState
{
	var SPACE_WIDTH:Int = 8;
	var FONT_SIZE:Int = 32;
	var TEXT_FIELD_HEIGHT:Int;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		TEXT_FIELD_HEIGHT = FONT_SIZE;

		FlxG.plugins.add(new MouseEventManager());
		var string = "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ";
		var textField = new FlxText(50, 60, 0,  string);
		textField.setFormat('assets/arabic.ttf', FONT_SIZE, FlxColor.BLUE, "center");
		add(textField);

		var splits = string.split(" ");

		// create one text field per word.
		// x accumulates the position of, where to put the next word
		var x:Int = cast(textField.x, Int);
		var y:Int = cast(textField.y, Int);
		var spaceWidth:Float = textField.size; // just a guess

		for (word in splits) {
			word = word.trim();
			var w = new FlxText(x, y, 0, word, cast(textField.size, Int));
			w.setFormat('assets/arabic.ttf', FONT_SIZE, FlxColor.WHITE, "center");

			// Semi-invisible bg to register the click event
			var bg = new FlxSprite(x, y);
			bg.z = -1;
			// Arabic needs to be padded by ~1.5x to capture tashkeel
			bg.makeGraphic(cast(w.width, Int), cast(TEXT_FIELD_HEIGHT * 1.5, Int), 0x44FF0000);
			add(bg);
			MouseEventManager.add(bg, function(o:FlxObject) {
				trace('Clicked on ${word}');
			});

			add(w);
			x += cast(w.width + SPACE_WIDTH, Int);
		}

		// remove(textField); // remove this once you're satisifed that the text
		// field placement closely matches the single-line field.
	}
}
