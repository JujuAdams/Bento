// Feather disable all

/// Completely resets the draw event scissor stack. This will set GPU state.

function __BentoScissorReset()
{
    static _scissorStack = __BentoSystem().__scissorStack;
    
    array_resize(_scissorStack, 0);
    
    var _surface = surface_get_target();
    if (surface_exists(_surface))
    {
        var _scissorData = {
            x: 0,
            y: 0,
            w: surface_get_width(_surface),
            h: surface_get_height(_surface),
        };
    }
    else if (BENTO_IN_GUI_DRAW_EVENT)
    {
        var _scissorData = {
            x: 0,
            y: 0,
            w: display_get_gui_width(),
            h: display_get_gui_height(),
        };
    }
    else
    {
        //Shouldn't happen so let's guess at an answer
        var _scissorData = {
            x: 0,
            y: 0,
            w: surface_get_width(application_surface),
            h: surface_get_height(application_surface),
        };
    }
    
    array_push(_scissorStack, _scissorData);
    
    return _scissorStack;
}