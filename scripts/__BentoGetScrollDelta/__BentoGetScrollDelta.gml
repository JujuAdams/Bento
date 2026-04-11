// Feather disable all

/// @param [element=self]

function __BentoGetScrollDelta(_element = self)
{
    static _result = {};
    
    var _dX     = 0;
    var _dY     = 0;
    var _parent = BENTO_NO_ELEMENT;
    var _tooBig = false;
    
    if (BentoExists(_element))
    {
        var _instanceBento = _element.BENTO_VARS;
        
        var _parent = __BentoFindScrollElement(_instanceBento.__parent);
        if (BentoExists(_parent))
        {
            with(_parent.BENTO_VARS)
            {
                if (__scissorEnabled)
                {
                    if (__scrollHori)
                    {
                        var _instL = _element.bentoLeft  - BENTO_SCROLL_TO_PADDING;
                        var _instR = _element.bentoRight + BENTO_SCROLL_TO_PADDING;
                        
                        if (__scissorEnabled)
                        {
                            var _parL = _parent.bentoLeft  + __scissorPadLeft  + __scissorScrollbarLeft;
                            var _parR = _parent.bentoRight - __scissorPadRight + __scissorScrollbarRight;
                        }
                        else
                        {
                            var _parL = _parent.bentoLeft;
                            var _parR = _parent.bentoRight;
                        }
                        
                        if (_instR - _instL > _parR - _parL)
                        {
                            //Try to place the element in the middle of the parent
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
                        var _instT = _element.bentoTop    - BENTO_SCROLL_TO_PADDING;
                        var _instB = _element.bentoBottom + BENTO_SCROLL_TO_PADDING;
                        
                        if (__scissorEnabled)
                        {
                            var _parT = _parent.bentoTop    + __scissorPadTop    + __scissorScrollbarTop;
                            var _parB = _parent.bentoBottom - __scissorPadBottom - __scissorScrollbarBottom;
                        }
                        else
                        {
                            var _parT = _parent.bentoTop;
                            var _parB = _parent.bentoBottom;
                        }
                        
                        if (_instB - _instT > _parB - _parT)
                        {
                            //Try to place the element in the middle of the parent
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