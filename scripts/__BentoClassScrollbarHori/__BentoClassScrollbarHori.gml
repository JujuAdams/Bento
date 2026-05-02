// Feather disable all

function __BentoClassScrollbarHori(_element) : __BentoClassScrollbar(_element) constructor
{
    exists = false;
    handleVisible = false;
    
    static __SetSize = function()
    {
        //TODO - Add awareness of the vertical scrollbar and adjust size/position accordingly
        
        var _element = __element;
        
        exists = true;
        
        if (__mirror)
        {
            //Top
            barLeft   = _element.bentoLeft + __padLeft;
            barTop    = _element.bentoTop + __padTop;
            barRight  = _element.bentoRight - __padRight;
            barBottom = _element.bentoTop + (__padTop + __thickness);
        }
        else
        {
            //Bottom
            barLeft   = _element.bentoLeft + __padLeft;
            barTop    = _element.bentoBottom - (barBottom + __thickness);
            barRight  = _element.bentoRight - __padRight;
            barBottom = _element.bentoBottom - __padBottom;
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
        var _cursorX = BentoCursorGetX();
        
        var _visibleWidth = _element.BENTO_VARS.__scrollVisibleWidth;
        var _contentWidth = _element.BENTO_VARS.__scrollContentWidth;
        
        if (_contentWidth <= _visibleWidth)
        {
            handleVisible = false;
            handleWidth = barWidth;
        }
        else
        {
            handleVisible = true;
            handleWidth = barWidth*clamp(_visibleWidth / _contentWidth, 0.1, 0.9);
        }
        
        handleLeft  = lerp(barLeft, barRight - handleWidth, BentoScrollGetParamX(_element));
        handleRight = handleLeft + handleWidth;
        
        if (BentoUsingPointer())
        {
            var _rangeWidth = max(1, barWidth - handleWidth);
            
            if (holdHandle)
            {
                if (BentoPrimaryGetHold(_element))
                {
                    var _left = _cursorX + __grabDelta - barLeft;
                    BentoScrollSetParamX(_left / _rangeWidth, infinity, _element);
                }
            }
            else
            {
                if (not BentoCursorGetHover(_element))
                {
                    hoverScrollbar = false;
                    hoverHandle = false;
                }
                else if (hoverScrollbar)
                {
                    hoverHandle = ((_cursorX >= handleLeft) && (_cursorX <= handleRight));
                
                    if (hoverHandle && BentoPrimaryGetPress(_element))
                    {
                        //Allow grabbing of the handle
                        holdHandle = true;
                        __grabDelta = handleLeft - _cursorX;
                    }
                    else if (BentoPrimaryGetClick(_element))
                    {
                        //Otherwise allow a single click to teleport the scroll handle
                        var _param = BentoScrollGetParamX(_element);
                        
                        if (_cursorX > handleRight)
                        {
                            _param += (_cursorX - handleRight) / _rangeWidth;
                        }
                        else if (_cursorX < handleLeft)
                        {
                            _param += (_cursorX - handleLeft) / _rangeWidth;
                        }
                        
                        BentoScrollSetParamX(_param, infinity, _element);
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
        
        if (not BentoPrimaryGetHold(_element))
        {
            holdHandle = false;
        }
    }
    
    //Not a static because we want to maintain scope on this method due to its use in the step order.
    __CheckOver = function(_mouseX, _mouseY, _holdElement)
    {
        if (point_in_rectangle(_mouseX, _mouseY, barLeft, barTop, barRight, barBottom))
        {
            hoverScrollbar = true;
            return __element;
        }
        else
        {
            hoverScrollbar = false;
            return undefined;
        }
    }
}