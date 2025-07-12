// Feather disable all

/// Draws a placeholder scrollbar using Programmer Art (tm) colored rectangles. The `dataStruct`
/// parameter should be set to the data returned by either `BentoScrollbarGetVertData()` or
/// `BentoScrollbarGetHoriData()`.
/// 
/// N.B. You should call this function in a Draw After user event / callback.
/// 
/// @param dataStruct
/// @param [element=self]

function BentoScrollbarDrawPlaceholder(_data, _element = self)
{
    var _baseAlpha = draw_get_alpha();
    
    with(_data)
    {
        if (exists)
        {
            if (hoverScrollbar || hoverHandle)
            {
                draw_set_alpha(_baseAlpha * 0.2);
                draw_rectangle(barLeft, barTop, barRight, barBottom, false);
                draw_set_alpha(_baseAlpha);
            }
            
            draw_rectangle(barLeft, barTop, barRight, barBottom, true);
            
            if (hoverHandle || holdHandle)
            {
                draw_set_alpha(_baseAlpha * 0.2);
                draw_rectangle(handleLeft+2, handleTop+2, handleRight-2, handleBottom-2, false);
                draw_set_alpha(_baseAlpha);
            }
            
            draw_rectangle(handleLeft+2, handleTop+2, handleRight-2, handleBottom-2, true);
        }
    }
}