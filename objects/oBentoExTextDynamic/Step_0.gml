//If we have a valid text update function then continually execute it to update our text
if (is_callable(funcTextUpdate))
{
    var _text = funcTextUpdate();
    if (_text != text)
    {
        text = _text;
        
        //Update the width of the element for layout purposes
        var _oldFont = draw_get_font();
        draw_set_font(font);
        BentoLayoutSetSize(string_width(text), undefined);
        draw_set_font(_oldFont);
    }
}