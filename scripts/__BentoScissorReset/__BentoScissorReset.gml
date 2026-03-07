// Feather disable all

/// Completely resets the draw event scissor stack. This will set GPU state.

function __BentoScissorReset()
{
    static _system = __BentoSystem();
    
    with(_system)
    {
        var _surface = surface_get_target();
        if (surface_exists(_surface))
        {
            var _x = 0;
            var _y = 0;
            var _w = surface_get_width(_surface);
            var _h = surface_get_height(_surface);
        }
        else if (BENTO_IN_GUI_DRAW_EVENT)
        {
            var _x = 0;
            var _y = 0;
            var _w = display_get_gui_width();
            var _h = display_get_gui_height();
        }
        else
        {
            //Shouldn't happen so let's guess at an answer
            var _x = 0;
            var _y = 0;
            var _w = surface_get_width(application_surface);
            var _h = surface_get_height(application_surface);
        }
        
        //Convert screen-space coordinates into Bento-space
        _x  = (_x - __globalScissorXOffset) / __globalScissorXScale;
        _y  = (_y - __globalScissorYOffset) / __globalScissorYScale;
        _w /= __globalScissorXScale;
        _h /= __globalScissorYScale;
        
        array_resize(__scissorStack, 0);
        array_push(__scissorStack, {
            x: _x,
            y: _y,
            w: _w,
            h: _h,
        });
        
        return __scissorStack;
    }
}