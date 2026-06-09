// Feather disable all

// You may specify the following variables when creating an instance of this object with
// `BentoCreate()`.
// 
// .text
//     The text to display. This should be a string. If not specified, no text is drawn.
// 
// .font
//     The font to display the text in. If not specified, the default native GameMaker is used.
// 
// .hAlign
//     The horizontal alignment in the alignment of the text within the element's bounding box. This
//     should be either `fa_left`, `fa_center`, or `fa_right`. If not specified, the horizontal alignment
//     will default to `fa_left`.
// 
// .vAlign
//     The vertical alignment in the alignment of the text within the element's bounding box. This should
//     be either `fa_top`, `fa_middle`, or `fa_bottom`. If not specified, the horizontal alignment will
//     default to `fa_top`.
// 
// Example:
// ```
// BentoCreate(oBentoExTextScribble, { text: "Hello world!", font: "fntBentoExCandyBeans", hAlign: fa_center, vAlign: fa_middle });
// ```

event_inherited();

// Ensure we have valid values for these variables
BentoVarEnsureMany(
    "text",   "",
    "font",   "fntBentoExCandyBeans",
    "hAlign", fa_left,
    "vAlign", fa_top,
);

if (not is_string(font))
{
    if (font_exists(font))
    {
        font = font_get_name(font);
    }
    else
    {
        font = "scribble_fallback_font";
    }
}

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

funcGetTextElement = function()
{
    return scribble(text, id)
           .align(hAlign, vAlign)
           .starting_format(font, image_blend);
}

var _textElement = funcGetTextElement();
var _stringWidth  = _textElement.get_width();
var _stringHeight = _textElement.get_height();
BentoLayoutSetSize(_stringWidth, _stringHeight);
BentoLayoutSetMinSize(min(_stringWidth, 30));

BentoLayoutText(function(_maxWidth, _maxHeight)
{
    return funcGetTextElement().fit_to_box(_maxWidth, _maxHeight).get_height();
});