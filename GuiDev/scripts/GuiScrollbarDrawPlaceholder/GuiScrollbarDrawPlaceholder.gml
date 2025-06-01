// Feather disable all

/// @param dataStruct
/// @param [element=self]

function GuiScrollbarDrawPlaceholder(_data, _element = self)
{
    draw_set_color((_data.overScrollbar || _data.overHandle)? c_gray : c_dkgray);
    draw_rectangle(_data.barLeft, _data.barTop, _data.barRight, _data.barBottom, false);
    
    draw_set_color((_data.overHandle || _data.grabHandle)? c_yellow : c_white);
    draw_rectangle(_data.handleLeft, _data.handleTop, _data.handleRight, _data.handleBottom, false);
    
    draw_set_color(c_white);
}