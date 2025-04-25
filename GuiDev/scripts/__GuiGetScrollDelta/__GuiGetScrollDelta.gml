// Feather disable all

/// @param [instance=id]

function __GuiGetScrollDelta(_instance = id)
{
    static _result = {};
    
    var _dX     = 0;
    var _dY     = 0;
    var _parent = noone;
    var _tooBig = false;
    
    if (instance_exists(_instance))
    {
        var _instanceGui = _instance.__gui;
        
        var _parent = __GuiScrollFindParent(_instanceGui.__parent);
        if (instance_exists(_parent))
        {
            with(_parent.__gui)
            {
                if (__scissorEnabled)
                {
                    var _instanceLeft   = _instanceGui.__solvedLeftLocal;
                    var _instanceTop    = _instanceGui.__solvedTopLocal;
                    var _instanceWidth  = _instanceGui.__solvedWidth;
                    var _instanceHeight = _instanceGui.__solvedHeight;
                    
                    if (__scrollHori)
                    {
                        if (_instanceWidth > __solvedWidth)
                        {
                            //Try to place the instance in the middle of the parent
                            _dX = (0.5*__solvedWidth - (_instanceLeft + 0.5*_instanceWidth)) - __scrollX;
                            _tooBig = true;
                        }
                        else
                        {
                            var _instL = __scrollX + _instanceLeft - GUI_SCROLL_TO_PADDING;
                            var _instR = __scrollX + _instanceLeft + _instanceWidth + GUI_SCROLL_TO_PADDING;
                            
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
                        if (_instanceHeight > __solvedHeight)
                        {
                            //Try to place the instance in the middle of the parent
                            _dY = (0.5*__solvedHeight - (_instanceTop + 0.5*_instanceHeight)) - __scrollY;
                            _tooBig = true;
                        }
                        else
                        {
                            var _instT = _instanceTop + __scrollY - GUI_SCROLL_TO_PADDING;
                            var _instB = _instanceTop + _instanceHeight + __scrollY + GUI_SCROLL_TO_PADDING;
                            
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
                }
            }
        }
    }
    
    _result.__dX     = _dX;
    _result.__dY     = _dY;
    _result.__parent = _parent;
    _result.__tooBig = _tooBig;
    
    return _result;
}