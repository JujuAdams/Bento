# Building From GML

Bento is intended to be used by loading UI layouts from files. This isn't always ideal and it is occasionally easier or (a little) safer to create UI from within your game application.

Building from GML is essentially the same as building from a file. You'll need to create a string that contains the Catspeak script that you'd like to execute, and then you'll need to execute that string. The syntax in a script run from a string versus run from a file is identical. Hot reloading is not supported when executing a string.

The easiest way to create a string that contains a Catspeak script is to use a ["string literal"](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Strings/Strings.htm). This is somewhat unusual syntax in GameMaker but is helpful here. A string literal is created like a normal string, but the first delimiter is preceeded by an `@` sign. The delimiter can be `"` or `'`. You cannot escape characters in a string literal so whatever delimiter you use to start the string literal cannot be used mid-string.

Despite their limitations, string literals are perfect for expressing multiline blocks of text, such as a Catspeak script. The example below shows how to create a game over modal when the player's `hp` variable falls to 0 (or below).

```
if (hp <= 0)
{
	if (not BentoLayerExists("game over modal"))
	{
		BentoStringExecute(@' //Start of string literal
			build BentoLayer {
				name = "game over modal"

				build BentoRectangle {
					width  = "100%"
					height = "100%"

					fillColor   = c_black
					fillAlpha   = 0.4
					borderAlpha = 0

					build BentoText {
						font = fntHeading
						label = "Game Over"
						color = c_red
					}

					captureClick = "action"
					click = fn {
						Clear()
						room_goto(rmMainMenu)
					}
				}
			}' //End of string literal
		);
	}
}
```

Internally, Catspeak scripts executed from strings are first compiled by Catspeak and then executed. Since compilation only needs to happen once (and is usually the slowest part of `BentoStringExecute()`), Bento will cache the result of the compilation internally. This means the next time that you execute the string Bento will already have the compiled script available for use making subsequent executions substantially faster. You can precompile strings by calling `BentoStringPreload()` before you need to execute that string if you want a further speed boost in-game.

Caching strings does use up memory. It's not a huge amount but for really complicated games it could add up significantly. You can set a limit on the number of strings held in the cache by setting the macro `BENTO_MAX_CACHED_STRINGS`. It defaults to 100 which should be plenty - try reducing this number if you're tight on resources.