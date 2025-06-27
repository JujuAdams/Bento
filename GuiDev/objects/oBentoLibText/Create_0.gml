// Feather disable all

event_inherited();

BentoSetIfNotDefined("text", "");
BentoSetIfNotDefined("font", -1);
BentoSetIfNotDefined("hAlign", fa_left);
BentoSetIfNotDefined("vAlign", fa_top);

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