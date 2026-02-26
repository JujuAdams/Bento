// Feather disable all

// This object defines a simple text element that can be used within a Bento UI layout. The text
// will wrap to a new line if the element width gets too small.
// 
// Example:
// ```
// BentoCreate(oBentoText, { text: "Hello world!" });
// ```

event_inherited();

// Ensure we have valid values for these variables
BentoSetIfNotDefined("text", "");
BentoSetIfNotDefined("font", -1);
BentoSetIfNotDefined("hAlign", fa_left);
BentoSetIfNotDefined("vAlign", fa_top);

var _oldFont = draw_get_font();
draw_set_font(font);
BentoLayoutSetSize(string_width(text), undefined);
BentoLayoutSetMinSize(20, undefined);
draw_set_font(_oldFont);

// Set up the rules to use when Bento calculates layouts
BentoLayoutText(function(_maxWidth)
{
    var _oldFont = draw_get_font();
    draw_set_font(font);
    var _result = string_height_ext(text, -1, _maxWidth);
    draw_set_font(_oldFont);
    
    return _result;
});