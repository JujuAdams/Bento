// Feather disable all

// This object defines a simple textbox element that can be used within a Bento UI layout.
// 
// Example:
// ```
// BentoCreate(oBentoText, { text: "Prefilled text", emptyText: "Enter text here!" });
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
BentoLayoutSetText(function(_maxWidth)
{
    var _oldFont = draw_get_font();
    draw_set_font(font);
    var _result = string_height_ext(text, -1, _maxWidth);
    draw_set_font(_oldFont);
    
    return _result;
});