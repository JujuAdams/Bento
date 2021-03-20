/// @param colour
/// @param alpha

function BentoTemplateRectangle(_colour, _alpha)
{
    rectangleColour = _colour;
    rectangleAlpha  = _alpha;
    
    EventAdd(BENTO_EVENT.DRAW, function(_left, _top, _right, _bottom)
    {
        var _oldColour = draw_get_colour();
        var _oldAlpha  = draw_get_alpha();
        
        draw_set_colour(rectangleColour);
        draw_set_alpha(rectangleAlpha);
        
        draw_rectangle(_left, _top, _right, _bottom, false);
        
        draw_set_colour(_oldColour);
        draw_set_alpha(_oldAlpha);
    });
}