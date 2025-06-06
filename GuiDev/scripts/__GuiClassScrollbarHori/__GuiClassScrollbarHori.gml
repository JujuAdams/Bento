// Feather disable all

function __GuiClassScrollbarHori(_element) : __GuiClassScrollbar(_element) constructor
{
    static __SetSize = function()
    {
        var _element = __element;
        
        if (__mirror)
        {
            //Top
            barLeft   = _element.guiLeft + __padLeft;
            barTop    = _element.guiTop + __padTop;
            barRight  = _element.guiRight - __padRight;
            barBottom = _element.guiTop + (__padTop + __thickness);
        }
        else
        {
            //Bottom
            barLeft   = _element.guiLeft + __padLeft;
            barTop    = _element.guiBottom - (barBottom + __thickness);
            barRight  = _element.guiRight - __padRight;
            barBottom = _element.guiBottom - __padBottom;
        }
        
        barWidth  = barRight - barLeft;
        barHeight = barBottom - barTop;
        
        handleTop    = barTop;
        handleBottom = barBottom;
        handleHeight = barHeight;
    }
    
    static __Update = function()
    {
        var _element = __element;
        var _cursorX = GuiCursorGetX();
        
        handleWidth = barWidth*clamp(barWidth / GuiScrollGetWidth(_element), 0.1, 1);
        handleLeft  = lerp(barLeft, barRight - handleWidth, GuiScrollGetParamX(_element));
        handleRight = handleLeft + handleWidth;
        
        if (GuiUsingPointer())
        {
            var _rangeWidth = max(1, barWidth - handleWidth);
            
            if (grabHandle)
            {
                if (GuiPrimaryGetHold(_element))
                {
                    var _left = _cursorX + __grabDelta - barLeft;
                    GuiScrollSetParamX(_left / _rangeWidth, infinity, _element);
                }
            }
            else
            {
                if (not GuiCursorGetHover(_element))
                {
                    hoverScrollbar = false;
                    hoverHandle = false;
                }
                else if (hoverScrollbar)
                {
                    hoverHandle = ((_cursorX >= handleLeft) && (_cursorX <= handleRight));
                
                    if (hoverHandle && GuiPrimaryGetPress(_element))
                    {
                        //Allow grabbing of the handle
                        grabHandle = true;
                        __grabDelta = handleLeft - _cursorX;
                    }
                    else if (GuiPrimaryGetClick(_element)) //FIXME - This has stopped working?
                    {
                        //Otherwise allow a single click to teleport the scroll handle
                        var _param = GuiScrollGetParamX(_element);
                        
                        if (_cursorX > handleRight)
                        {
                            _param += (_cursorX - handleRight) / _rangeWidth;
                        }
                        else if (_cursorX < handleLeft)
                        {
                            _param += (_cursorX - handleLeft) / _rangeWidth;
                        }
                        
                        GuiScrollSetParamX(_param, infinity, _element);
                    }
                }
                else
                {
                    //Pointer isn't over the scrollbar at all
                    hoverHandle = false;
                }
            }
        }
        else
        {
            hoverScrollbar = false;
            hoverHandle = false;
        }
        
        if (not GuiPrimaryGetHold(_element))
        {
            grabHandle = false;
        }
    }
}