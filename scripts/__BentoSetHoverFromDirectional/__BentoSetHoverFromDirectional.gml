// Feather disable all

/// @param startElement
/// @param dX
/// @param dY

function __BentoSetHoverFromDirectional(_prevElement, _dX, _dY)
{
    static _excludeArray = [];
    
    //Can't hover anything when there are blocking animations on this layer.
    if (not ds_map_empty(__animBlockingMap)) return BENTO_NO_ELEMENT;
    
    _excludeArray[0] = _prevElement;
    var _nextElement = BENTO_NO_ELEMENT;
    
    if (not __BentoGetHoverableInternal(_prevElement, false))
    {
        //The element we were previously highlighting is no longer valid (see __BentoGetHoverableInternal())
        
        if (__BentoGetHoverableInternal(__hoverElementSoft, false))
        {
            //Choose the soft selection if possible
            _nextElement = __hoverElementSoft;
        }
        else
        {
            //Otherwise fall back on searching for the nearest selectable element
            _nextElement = __BentoGetNearest(__directionalLastX, __directionalLastY, _excludeArray);
        }
        
        __BentoSetHover(_nextElement, false);
    }
    else
    {
        var _prevBento = _prevElement.BENTO_VARS;
        
        //Previously selected element is valid, process navigation
        if ((_dX == 0) && (_dY == 0))
        {
            //No movement, keep the same element we had before
            _nextElement = _prevElement;
        }
        else
        {
            //Don't allow selection of the next element if we're not visible
            if (not BentoClipGetFullyVisible(_prevElement))
            {
                BentoScrollTo(BentoScrollGetSpeed(_prevElement), _prevElement);
                _nextElement = _prevElement;
            }
            else
            {
                //Choose a predefined navigable element if possible
                if (_dX < 0)
                {
                    _nextElement = _prevBento.__linkLeft;
                }
                else if (_dX > 0)
                {
                    _nextElement = _prevBento.__linkRight;
                }
                else if (_dY < 0)
                {
                    _nextElement = _prevBento.__linkUp;
                }
                else if (_dY > 0)
                {
                    _nextElement = _prevBento.__linkDown;
                }
            
                //Only check if the next element is properly visible if it's nested inside a different scroller to
                //the previous element. This ensures non-visible elements never get selected but that it's possible
                //to navigate to visually hidden elements inside the scroller.
                var _prevScrollParent = __BentoScrollFindParent(_prevElement);
                var _checkVisible = (_prevScrollParent != __BentoScrollFindParent(_nextElement)); //FIXME - Change to a check against the joint scissor and scroll parent
                if (not __BentoGetHoverableInternal(_nextElement, _checkVisible))
                {
                    _nextElement = BENTO_NO_ELEMENT;
                }
            
                if (not BentoExists(_nextElement))
                {
                    //If the navigation element isn't selectable then fall back on a raycast
                
                    if (((_dX != 0) && (not _prevBento.__raycastEnableX)) || ((_dY != 0) && (not _prevBento.__raycastEnableY)))
                    {
                        //Raycast is disabled for the previous element!
                        _nextElement = _prevElement;
                    }
                    else
                    {
                        _nextElement = __BentoGetRaycast(__directionalLastX, __directionalLastY, _dX, _dY, _excludeArray, _prevScrollParent);
                    
                        if (not BentoExists(_nextElement))
                        {
                            //Raycast failed, no new element can be selected
                            _nextElement = _prevElement;
                        }
                    }
                }
            }
        }
        
        __BentoSetHover(_nextElement, true);
    }
}