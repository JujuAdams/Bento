// Feather disable all

event_inherited();

BentoSetIfNotDefined("text", "");
BentoSetIfNotDefined("option", undefined);

BentoSetButton(BENTO_BUTTON_ALWAYS);

if (text != "")
{
    var _oldFont = draw_get_font();
    draw_set_font(-1);
    
    var _height = max(50, string_height(text));
    BentoLayoutSetSize(string_width(text) + _height + 7, _height);
    
    draw_set_font(_oldFont);
}