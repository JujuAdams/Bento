// Feather disable all

/// Scrolls to highlight an instance inside a parent.
/// 
/// @param instance

function GuiScrollTo(_instance)
{
    if (not instance_exists(_instance)) return;
    
    var _parent = __GuiScrollFindParent(_instance);
    if (not instance_exists(_instance)) return;
    if (_parent == _instance) return;
    
    with(_parent)
    {
        var _dX = 0;
        var _dY = 0;
        
        if (__scrollHori)
        {
            if (_instance.sprite_width > sprite_width)
            {
                //Try to place the instance in the middle of the parent
                _dX = 0.5*(bbox_left + bbox_right) - 0.5*(_instance.bbox_left + _instance.bbox_right);
            }
            else
            {
                var _instL = _instance.bbox_left  - (variable_instance_get(_instance, "scrollMarginLeft" ) ?? 0);
                var _instR = _instance.bbox_right + (variable_instance_get(_instance, "scrollMarginRight") ?? 0);
                var _parL  = __scissorEnabled? (bbox_left  + __scissorPadLeft ) : bbox_left;
                var _parR  = __scissorEnabled? (bbox_right - __scissorPadRight) : bbox_right;
                var _distL = _parL - _instL;
                var _distR = _parR - _instR;
                
                if (_distL > 0)
                {
                    if (_distR < 0)
                    {
                        _dX = (abs(_distL) < abs(_distR))? _distL : _distR;
                    }
                    else
                    {
                        _dX = _distL;
                    }
                }
                else if (_distR < 0)
                {
                    _dX = _distR;
                }
            }
        }
        
        if (__scrollVert)
        {
            if (_instance.sprite_height > sprite_height)
            {
                //Try to place the instance in the middle of the parent
                _dY = 0.5*(bbox_top + bbox_bottom) - 0.5*(_instance.bbox_top + _instance.bbox_bottom);
            }
            else
            {
                var _instT = _instance.bbox_top    - (variable_instance_get(_instance, "scrollMarginTop"   ) ?? 0);
                var _instB = _instance.bbox_bottom + (variable_instance_get(_instance, "scrollMarginBottom") ?? 0);
                var _parT  = __scissorEnabled? (bbox_top    + __scissorPadTop   ) : bbox_top;
                var _parB  = __scissorEnabled? (bbox_bottom - __scissorPadBottom) : bbox_bottom;
                var _distT = _parT - _instT;
                var _distB = _parB - _instB;
                
                if (_distT > 0)
                {
                    if (_distB < 0)
                    {
                        _dY = (abs(_distT) < abs(_distB))? _distT : _distB;
                    }
                    else
                    {
                        _dY = _distT;
                    }
                }
                else if (_distB < 0)
                {
                    _dY = _distB;
                }
            }
        }
        
        GuiScrollMove(_dX, _dY);
    }
}