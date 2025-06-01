// Feather disable all

/// @param [element=self]

function __GuiGetScrollDelta(_element = self)
{
    static _result = {};
    
    var _dX     = 0;
    var _dY     = 0;
    var _parent = noone;
    var _tooBig = false;
    
    if (GuiExists(_element))
    {
        var _instanceGui = _element.GUI_VARS;
        
        var _parent = __GuiScrollFindParent(_instanceGui.__parent);
        if (GuiExists(_parent))
        {
            with(_parent.GUI_VARS)
            {
                if (__scissorEnabled)
                {
                    if (__scrollHori)
                    {
                        var _instL = _element.guiLeft  - GUI_SCROLL_TO_PADDING;
                        var _instR = _element.guiRight + GUI_SCROLL_TO_PADDING;
                        
                        if (__scissorEnabled)
                        {
                            var _parL = _parent.guiLeft  + __scissorPadLeft  + __scissorScrollbarLeft;
                            var _parR = _parent.guiRight - __scissorPadRight + __scissorScrollbarRight;
                        }
                        else
                        {
                            var _parL = _parent.guiLeft;
                            var _parR = _parent.guiRight;
                        }
                        
                        if (_instR - _instL > __solvedWidth)
                        {
                            //Try to place the instance in the middle of the parent
                            _dX = (0.5*(_parL + _parR) - 0.5*(_instL + _instR)) - __scrollX;
                            _tooBig = true;
                        }
                        else
                        {
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
                        var _instT = _element.guiTop    - GUI_SCROLL_TO_PADDING;
                        var _instB = _element.guiBottom + GUI_SCROLL_TO_PADDING;
                        
                        if (__scissorEnabled)
                        {
                            var _parT = _parent.guiTop    + __scissorPadTop    + __scissorScrollbarTop;
                            var _parB = _parent.guiBottom - __scissorPadBottom - __scissorScrollbarBottom;
                        }
                        else
                        {
                            var _parT = _parent.guiTop;
                            var _parB = _parent.guiBottom;
                        }
                        
                        if (_instB - _instT > __solvedHeight)
                        {
                            //Try to place the instance in the middle of the parent
                            _dY = (0.5*(_parT + _parB) - 0.5*(_instT + _instB)) - __scrollY;
                            _tooBig = true;
                        }
                        else
                        {
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