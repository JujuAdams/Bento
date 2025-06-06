// Feather disable all

function __GuiClassScrollbarVert(_element) : __GuiClassScrollbar(_element) constructor
{
    static __SetSize = function()
    {
        var _element = __element;
        
        if (__mirror)
        {
            //Left
            barLeft   = _element.guiLeft + __padLeft;
            barTop    = _element.guiTop + __padTop;
            barRight  = _element.guiLeft + (__padLeft + __thickness);
            barBottom = _element.guiBottom - __padBottom;
        }
        else
        {
            //Right
            barLeft   = _element.guiRight - (__padRight + __thickness);
            barTop    = _element.guiTop + __padTop;
            barRight  = _element.guiRight - __padRight;
            barBottom = _element.guiBottom - __padBottom;
        }
        
        barWidth  = barRight - barLeft;
        barHeight = barBottom - barTop;
        
        handleLeft  = barLeft;
        handleRight = barRight;
        handleWidth = barWidth;
    }
    
    static __Update = function()
    {
        var _element = __element;
        var _cursorX = GuiCursorGetX();
        var _cursorY = GuiCursorGetY();
        
        handleHeight = barHeight*clamp(barHeight / GuiScrollGetHeight(_element), 0.1, 1);
        handleTop    = lerp(barTop, barBottom - handleHeight, GuiScrollGetParamY(_element));
        handleBottom = handleTop + handleHeight;
        
        if (GuiUsingPointer())
        {
            var _rangeHeight = max(1, barHeight - handleHeight);
            
            if (grabHandle)
            {
                if (GuiPrimaryGetHold(_element))
                {
                    var _top = _cursorY + __grabDelta - barTop;
                    GuiScrollSetParamY(_top / _rangeHeight, infinity, _element);
                }
            }
            else
            {
                if (not GuiCursorGetOver(_element))
                {
                    overScrollbar = false;
                    overHandle = false;
                }
                else if (overScrollbar)
                {
                    overHandle = ((_cursorY >= handleTop) && (_cursorY <= handleBottom));
                
                    if (overHandle && GuiPrimaryGetPress(_element))
                    {
                        //Allow grabbing of the handle
                        grabHandle = true;
                        __grabDelta = handleTop - _cursorY;
                    }
                    else if (GuiPrimaryGetClick(_element)) //FIXME - This has stopped working?
                    {
                        //Otherwise allow a single click to teleport the scroll handle
                        var _param = GuiScrollGetParamY(_element);
                        
                        if (_cursorY > handleBottom)
                        {
                            _param += (_cursorY - handleBottom) / _rangeHeight;
                        }
                        else if (_cursorY < handleTop)
                        {
                            _param += (_cursorY - handleTop) / _rangeHeight;
                        }
                        
                        GuiScrollSetParamY(_param, infinity, _element);
                    }
                }
                else
                {
                    //Pointer isn't over the scrollbar at all
                    overHandle = false;
                }
            }
        }
        else
        {
            overScrollbar = false;
            overHandle = false;
        }
        
        if (not GuiPrimaryGetHold(_element))
        {
            grabHandle = false;
        }
    }
}