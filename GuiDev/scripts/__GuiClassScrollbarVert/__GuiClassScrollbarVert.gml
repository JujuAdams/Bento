// Feather disable all

function __GuiClassScrollbarVert(_element) : __GuiClassScrollbar(_element) constructor
{
    static __SetSize = function()
    {
        var _element = __element;
        
        if (__mirror)
        {
            //Left
            __barLeft   = _element.guiLeft + __padLeft;
            __barTop    = _element.guiTop + __padTop;
            __barRight  = _element.guiLeft + (__padLeft + __thickness);
            __barBottom = _element.guiBottom - __padBottom;
        }
        else
        {
            //Right
            __barLeft   = _element.guiRight - (__padRight + __thickness);
            __barTop    = _element.guiTop + __padTop;
            __barRight  = _element.guiRight - __padRight;
            __barBottom = _element.guiBottom - __padBottom;
        }
        
        __barWidth  = __barRight - __barLeft;
        __barHeight = __barBottom - __barTop;
        
        __handleLeft  = __barLeft;
        __handleRight = __barRight;
        __handleWidth = __barWidth;
    }
    
    static __Update = function()
    {
        var _element = __element;
        var _cursorX = GuiCursorGetX();
        var _cursorY = GuiCursorGetY();
        
        __handleHeight = __barHeight*clamp(__barHeight / GuiScrollGetHeight(_element), 0.1, 1);
        __handleTop    = lerp(__barTop, __barBottom - __handleHeight, GuiScrollGetParamY(_element));
        __handleBottom = __handleTop + __handleHeight;
        
        if (GuiUsingPointer())
        {
            var _rangeHeight = max(1, __barHeight - __handleHeight);
            
            if (__grabHandle)
            {
                if (GuiPrimaryGetHold(_element))
                {
                    var _top = _cursorY + __grabDelta - __barTop;
                    GuiScrollSetParamY(_top / _rangeHeight, infinity, _element);
                }
            }
            else
            {
                __overScrollbar = point_in_rectangle(_cursorX, _cursorY, __barLeft, __barTop, __barRight, __barBottom);
                if (__overScrollbar)
                {
                    __overHandle = ((_cursorY >= __handleTop) && (_cursorY <= __handleBottom));
                
                    if (__overHandle && GuiPrimaryGetPress(_element))
                    {
                        //Allow grabbing of the handle
                        __grabHandle = true;
                        __grabDelta = __handleTop - _cursorY;
                    }
                    else if (GuiPrimaryGetClick(_element))
                    {
                        //Otherwise allow a single click to teleport the scroll handle
                        var _param = GuiScrollGetParamY(_element);
                    
                        if (_cursorY > __handleBottom)
                        {
                            _param += (_cursorY - __handleBottom) / _rangeHeight;
                        }
                        else if (_cursorY < __handleTop)
                        {
                            _param += (_cursorY - __handleTop) / _rangeHeight;
                        }
                    
                        GuiScrollSetParamY(_param, infinity, _element);
                    }
                }
                else
                {
                    //Pointer isn't over the scrollbar at all
                    __overHandle = false;
                }
            }
        }
        else
        {
            __overHandle = false;
        }
        
        if (not GuiPrimaryGetHold(_element))
        {
            __grabHandle = false;
        }
    }
}