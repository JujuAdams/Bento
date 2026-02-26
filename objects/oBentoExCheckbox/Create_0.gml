// Feather disable all

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoVarEnsureMany(
    "text", "",
);

BentoSetButton(BENTO_BUTTON_ALWAYS);

if (text != "")
{
    var _oldFont = draw_get_font();
    draw_set_font(-1);
    
    var _height = max(50, string_height(text));
    BentoLayoutSetSize(string_width(text) + _height + 7, _height);
    
    draw_set_font(_oldFont);
}