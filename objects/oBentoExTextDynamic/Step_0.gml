//If we have a valid text update function then continually execute it to update our text
if (is_callable(__funcTextUpdate))
{
    text = string(__funcTextUpdate());
}

if (text != __prevText)
{
    __prevText = text;
    
    //Update the width of the element for layout purposes
    var _oldFont = draw_get_font();
    draw_set_font(font);
    var _stringWidth = string_width(text);
    BentoLayoutSetSize(_stringWidth, string_height(text));
    BentoLayoutSetMinSize(min(_stringWidth, 4*string_width(" ")));
    draw_set_font(_oldFont);
}