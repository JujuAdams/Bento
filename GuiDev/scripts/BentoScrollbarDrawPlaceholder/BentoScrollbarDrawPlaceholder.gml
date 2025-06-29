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
    draw_set_color((_data.hoverScrollbar || _data.hoverHandle)? c_gray : c_dkgray);
    draw_rectangle(_data.barLeft, _data.barTop, _data.barRight, _data.barBottom, false);
    
    draw_set_color((_data.hoverHandle || _data.holdHandle)? c_yellow : c_white);
    draw_rectangle(_data.handleLeft, _data.handleTop, _data.handleRight, _data.handleBottom, false);
    
    draw_set_color(c_white);
}