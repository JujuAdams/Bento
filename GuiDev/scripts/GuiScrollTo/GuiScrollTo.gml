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
        
        if (_instance.sprite_width > sprite_width)
        {
            _dX = x - _instance.x;
        }
        else
        {
            var _instL = _instance.bbox_left - _instance.scrollMarginLeft;
            var _instR = _instance.bbox_right + _instance.scrollMarginRight;
            var _parL  = __scissorState? __scissorLeft : bbox_left;
            var _parR  = __scissorState? __scissorRight : bbox_right;
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
        
        if (_instance.sprite_height > sprite_height)
        {
            _dY = y - _instance.y;
        }
        else
        {
            var _instT = _instance.bbox_top - _instance.scrollMarginTop;
            var _instB = _instance.bbox_bottom + _instance.scrollMarginBottom;
            var _parT  = __scissorState? __scissorTop : bbox_top;
            var _parB  = __scissorState? __scissorBottom : bbox_bottom;
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
        
        GuiScrollMove(_dX, _dY);
    }
}