// Feather disable all

function __BentoClassScrollbarVert(_element) : __BentoClassScrollbar(_element) constructor
{
    static __SetSize = function()
    {
        var _element = __element;
        
        if (__mirror)
        {
            //Left
            barLeft   = _element.bentoLeft + __padLeft;
            barTop    = _element.bentoTop + __padTop;
            barRight  = _element.bentoLeft + (__padLeft + __thickness);
            barBottom = _element.bentoBottom - __padBottom;
        }
        else
        {
            //Right
            barLeft   = _element.bentoRight - (__padRight + __thickness);
            barTop    = _element.bentoTop + __padTop;
            barRight  = _element.bentoRight - __padRight;
            barBottom = _element.bentoBottom - __padBottom;
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
        var _cursorY = BentoCursorGetY();
        
        handleHeight = barHeight*clamp(barHeight / BentoScrollGetHeight(_element), 0.1, 1);
        handleTop    = lerp(barTop, barBottom - handleHeight, BentoScrollGetParamY(_element));
        handleBottom = handleTop + handleHeight;
        
        if (BentoUsingPointer())
        {
            var _rangeHeight = max(1, barHeight - handleHeight);
            
            if (holdHandle)
            {
                if (BentoPrimaryGetHold(_element))
                {
                    var _top = _cursorY + __grabDelta - barTop;
                    BentoScrollSetParamY(_top / _rangeHeight, infinity, _element);
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
                    hoverHandle = ((_cursorY >= handleTop) && (_cursorY <= handleBottom));
                
                    if (hoverHandle && BentoPrimaryGetPress(_element))
                    {
                        //Allow grabbing of the handle
                        holdHandle = true;
                        __grabDelta = handleTop - _cursorY;
                    }
                    else if (BentoPrimaryGetClick(_element)) //FIXME - This has stopped working?
                    {
                        //Otherwise allow a single click to teleport the scroll handle
                        var _param = BentoScrollGetParamY(_element);
                        
                        if (_cursorY > handleBottom)
                        {
                            _param += (_cursorY - handleBottom) / _rangeHeight;
                        }
                        else if (_cursorY < handleTop)
                        {
                            _param += (_cursorY - handleTop) / _rangeHeight;
                        }
                        
                        BentoScrollSetParamY(_param, infinity, _element);
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
}