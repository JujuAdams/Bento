# Text Layout

?> You should read up on how Bento [draws elements](Topic-Drawing-Elements) before reading this article.

Text rendering is a complex topic that I seem to keep running into. This page will go over the basic concepts surrounding text rendering in Bento and how to use Scribble Jr. and Scribble Deluxe to improve text in your game.

&nbsp;

## Simple Text

Drawing text in Bento works similarly to drawing other content, such as sprites. Imagine an element object that inherits from `oBentoAncestor` as all Bento elements do. We can render text by setting up the following events:

```gml
/// Create
text = "Hello World!";
font = fntDefault;
```

```gml
/// User Event 1 - Draw
draw_set_font(font);
draw_text(bentoLeft, bentoTop, text);
draw_set_font(-1);
```

What we've done here is make a simple element draw some text. However, we haven't set the actual width and height of the element. As a result, the text we're drawing has no dimensions within Bento's layout algorithm and will instead be treating as having a tiny width and height. Occasionally this is what we want but usually we want our text to occupy space in the layout. What we can do is set the instance's rectangular dimensions and then draw our text inside that rectangle. We can do this by adjusting the Create event to:

```gml
/// Create
text = "Hello World!";
font = fntDefault;

//Set the font we want to use (temporarily)
var _oldFont = draw_get_font();
draw_set_font(font);

//Set the size of this element to be the size of the text when drawn
BentoLayoutSetSize(string_width(text), string_height(text));

//Restore the old font
draw_set_font(_oldFont);
```

&nbsp;

## Wrapped Text

The above example is sufficient for simple static text. However, for text that needs wrapping, such as a textbox showing character dialogue, then we need to think more flexibly. Let's add a `maxWidth` variable and then use GameMaker's native text wrapping to set our element's dimensions:

```gml
/// Create
text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
font = fntDefault;
maxWidth = 150; //Set a maximum width for our text

//Set the font we want to use (temporarily)
var _oldFont = draw_get_font();
draw_set_font(font);
//Set the size of this element to be the size of the text after wrapping
BentoLayoutSetSize(maxWidth, string_height_ext(text, -1, maxWidth));
draw_set_font(_oldFont);
```

```gml
/// User Event 1 - Draw
draw_set_font(font);
draw_text_ext(bentoLeft, bentoTop, text, -1, maxWidth);
draw_set_font(-1);
```

This is pretty good! By using GameMaker's native text wrapping we can precalculate the correct height for the element. However, we've traded one problem for another. By setting an unchanging `maxWidth` value we've allowed for text wrapping but we've made it so that Bento can't dynamically adjust the width of the textbox if the overall layout algorithm needs to.

To solve this shortcoming we need to introduce some way for us to recalculate the height of the textbox based on the width made available to the element by Bento. This is done using the `BentoLayoutText()` function, a special function made specifically for text layouts. This function allows us to define a function that Bento will call when it needs to check the y-axis size of text after it is wrapped. We can call `BentoLayoutText()` in the Create to set up dynamic height resizing like so:

```gml
/// Create
text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
font = fntDefault;

var _oldFont = draw_get_font();
draw_set_font(font);
//Set the initial size of this element to be the size of the text when drawn
BentoLayoutSetSize(string_width(text), string_height(text));
draw_set_font(_oldFont);

//Set up the rules to use when Bento calculates layouts
BentoLayoutText(function(_maxWidth, _maxHeight)
{
    var _oldFont = draw_get_font();
    draw_set_font(font);
    var _result = string_height_ext(text, -1, _maxWidth);
    draw_set_font(_oldFont);
    
    return _result;
});
```

```gml
/// User Event 1 - Draw
draw_set_font(font);
draw_text_ext(bentoLeft, bentoTop, text, -1, bentoWidth);
draw_set_font(-1);
```

&nbsp;

## Scribble Deluxe

Bento's flexible layout system integrates nicely with Scribble Deluxe. You can use the `.get_height()`  method to return the height of text from Scribble. The example below uses the `.fit_to_box()` method which will scale down and reflow text until it fits inside the given maximum bounds.

```gml
/// Create
text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
font = fntDefault;

var _textElement = scribble(text, id).starting_format(font, c_white);
BentoLayoutSetSize(_textElement.get_width(), _textElement.get_height());

BentoLayoutText(function(_maxWidth, _maxHeight)
{
    return scribble(text, id)
           .starting_format(font, c_white)
           .fit_to_box(_maxWidth, _maxHeight)
           .get_height();
});
```

```gml
/// User Event 1 - Draw
scribble(text, id)
.starting_format(font, c_white)
.fit_to_box(bentoWidth, bentoHeight)
.draw(_x, _y);
```

&nbsp;

## Scribble Jr.

Scribble Jr. can also be used with Bento in much the same way.

```gml
/// Create
text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
font = fntDefault;

var _textElement = ScribblejrFitExt(text, fa_left, fa_top, font)
BentoLayoutSetSize(_textElement.GetWidth(), _textElement.GetHeight());

BentoLayoutText(function(_maxWidth, _maxHeight)
{
    return ScribblejrFitExt(text, fa_left, fa_top, font, undefined, _maxWidth, _maxHeight)
           .GetHeight();
});
```

```gml
/// User Event 1 - Draw
ScribblejrFitExt(text, fa_left, fa_top, font, undefined, bentoWidth, bentoHeight)
.Draw(_x, _y, c_white, 1);
```
