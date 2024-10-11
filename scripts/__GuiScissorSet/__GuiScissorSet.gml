// Feather disable all

/// @param left
/// @param top
/// @param width
/// @param height

function __GuiScissorSet(_left, _top, _width, _height)
{
    var _surface = surface_get_target();
    if (_surface < 0)
    {
        var _xScale = window_get_width() / display_get_gui_width();
        var _yScale = window_get_height() / display_get_gui_height();
        
        _left   *= _xScale;
        _top    *= _yScale;
        _width  *= _xScale;
        _height *= _yScale;
    }
    else if (_surface == application_surface)
    {
        if (view_get_visible(view_current))
        {
            var _camera = view_get_camera(view_current);
            if (_camera >= 0)
            {
                var _xScale = surface_get_width(application_surface) / camera_get_view_width(_camera);
                var _yScale = surface_get_height(application_surface) / camera_get_view_height(_camera);
                
                _left   *= _xScale;
                _top    *= _yScale;
                _width  *= _xScale;
                _height *= _yScale;
            }
        }
    }
    
    gpu_set_scissor(_left, _top, _width, _height);
}