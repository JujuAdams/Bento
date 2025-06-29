// Feather disable all

// This object defines a simple textbox element that can be used within a Bento UI layout.
// 
// Example:
// ```
// BentoCreateObject(oBentoText, { text: "Prefilled text", emptyText: "Enter text here!" });
// ```

event_inherited();

// Ensure we have valid values for these variables
BentoSetIfNotDefined("text", "");
BentoSetIfNotDefined("font", -1);
BentoSetIfNotDefined("hAlign", fa_left);
BentoSetIfNotDefined("vAlign", fa_top);

// Set up the rules to use when Bento calculates layouts
BentoLayoutSetText(
    function(_forceString) //Measure width
    {
        var _oldFont = draw_get_font();
        draw_set_font(font);
        var _result = string_width(_forceString ?? text);
        draw_set_font(_oldFont);
        
        return _result;
    },
    
    function(_forceString, _maxWidth) //Measure height
    {
        var _oldFont = draw_get_font();
        draw_set_font(font);
        var _result = string_height_ext(_forceString ?? text, -1, _maxWidth);
        draw_set_font(_oldFont);
        
        return _result;
    }
);