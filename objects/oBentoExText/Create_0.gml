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
BentoVarEnsureMany(
    "text",   "",
    "font",   -1,
    "hAlign", fa_left,
    "vAlign", fa_top,
);

//If we have a function for the `.text` variable then store that function in a different variable
if (is_callable(text))
{
    funcTextUpdate = method(self, text);
    text = funcTextUpdate();
}
else
{
    funcTextUpdate = undefined;
}

//Set the layout parameters based on the size of the string when drawn
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