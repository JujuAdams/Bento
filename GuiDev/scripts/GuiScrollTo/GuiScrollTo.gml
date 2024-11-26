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
        
        if (_instance.width > width)
        {
            _dX = x - _instance.x;
        }
        else
        {
            var _instL = _instance.x - _instance.width/2 - _instance.scrollMarginLeft;
            var _instR = _instance.x + _instance.width/2 + _instance.scrollMarginRight;
            var _parL  = __scissorState? __scissorLeft : (x - width/2);
            var _parR  = __scissorState? __scissorRight : (x + width/2);
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
        
        if (_instance.height > height)
        {
            _dY = y - _instance.y;
        }
        else
        {
            var _instT = _instance.y - _instance.height/2 - _instance.scrollMarginTop;
            var _instB = _instance.y + _instance.height/2 + _instance.scrollMarginBottom;
            var _parT  = __scissorState? __scissorTop : (y - height/2);
            var _parB  = __scissorState? __scissorBottom : (y + height/2);
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