// Feather disable all

// This object defines a simple text element that can be used within a Bento UI layout. The text
// will wrap to a new line if the element width gets too small. You cannot change the text after
// the instance has been created (please use `oBentoExTextDynamic` instead).
// 
// As with everything in Bento, a text element is fundamentally a rectangular box. Imagine the text
// element as an invisible box that can change shape depending on the layout algorithm. Text is
// then drawn inside that box.
// 
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
// BentoCreate(oBentoText, { text: "Hello world!", font: fntBentoExCandyBeans, hAlign: fa_center, vAlign: fa_middle });
// ```

event_inherited();

// Ensure we have valid values for these variables
BentoVarEnsureMany(
    "text",   "",
    "font",   fntBentoExCandyBeans,
    "hAlign", fa_left,
    "vAlign", fa_top,
);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}

//Set the layout parameters based on the size of the string when drawn
var _oldFont = draw_get_font();
draw_set_font(font);
var _stringWidth = string_width(text);
BentoLayoutSetSize(_stringWidth, string_height(text));
BentoLayoutSetMinSize(min(_stringWidth, 4*string_width(" ")));
draw_set_font(_oldFont);

// Set up the rules to use when Bento calculates layouts
BentoLayoutText(function(_maxWidth, _maxHeight)
{
    var _oldFont = draw_get_font();
    draw_set_font(font);
    var _result = string_height_ext(text, -1, _maxWidth);
    draw_set_font(_oldFont);
    
    return _result;
});