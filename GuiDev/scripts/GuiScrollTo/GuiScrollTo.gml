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
            if (_instance.__solvedWidth > __solvedWidth)
            {
                //Try to place the instance in the middle of the parent
                _dX = 0.5*__solvedWidth - (_instance.__solvedLeftLocal + 0.5*_instance.__solvedWidth);
            }
            else
            {
                var _instL = _instance.__solvedLeftLocal + __scrollX - GUI_SCROLL_TO_PADDING;
                var _instR = _instance.__solvedLeftLocal + _instance.__solvedWidth + __scrollX + GUI_SCROLL_TO_PADDING;
                
                if (__scissorEnabled)
                {
                    _parL = __scissorPadLeft;
                    _parR = __solvedWidth - __scissorPadRight;
                }
                else
                {
                    var _parL = 0;
                    var _parR = __solvedWidth;
                }
                
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
            if (_instance.__solvedHeight > __solvedHeight)
            {
                //Try to place the instance in the middle of the parent
                _dY = 0.5*__solvedHeight - (_instance.__solvedTopLocal + 0.5*_instance.__solvedHeight);
            }
            else
            {
                var _instT = _instance.__solvedTopLocal + __scrollY - GUI_SCROLL_TO_PADDING;
                var _instB = _instance.__solvedTopLocal + _instance.__solvedHeight + __scrollY + GUI_SCROLL_TO_PADDING;
                
                if (__scissorEnabled)
                {
                    var _parT = __scissorPadTop;
                    var _parB = __solvedHeight - __scissorPadBottom;
                }
                else
                {
                    var _parT = 0;
                    var _parB = __solvedHeight;
                }
                
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