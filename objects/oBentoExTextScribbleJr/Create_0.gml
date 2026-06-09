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
// BentoCreate(oBentoExTextScribbleJr, { text: "Hello world!", font: fntBentoExCandyBeans, hAlign: fa_center, vAlign: fa_middle });
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

var _textElement = ScribblejrFitExt(text, hAlign, vAlign, font)
BentoLayoutSetSize(_textElement.GetWidth(), _textElement.GetHeight());
BentoLayoutSetMinSize(min(_textElement.GetWidth(), 30));

BentoLayoutText(function(_maxWidth, _maxHeight)
{
    return ScribblejrFitExt(text, hAlign, vAlign, font, undefined, _maxWidth, _maxHeight).GetHeight();
});