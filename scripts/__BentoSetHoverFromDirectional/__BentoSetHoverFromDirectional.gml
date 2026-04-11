// Feather disable all

/// @param startElement
/// @param dX
/// @param dY

function __BentoSetHoverFromDirectional(_prevElement, _dX, _dY)
{
    static _raycastData = {};
    static _wrappedRaycastData = {};
    
    //Can't hover anything when there are blocking animations on this layer.
    if (not ds_map_empty(__animBlockingMap)) return BENTO_NO_ELEMENT;
    
    var _exclude = (_prevElement != BENTO_NO_ELEMENT)? _prevElement.BENTO_VARS : undefined;
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
            _nextElement = __BentoGetDirectionalNearest(__directionalLastX, __directionalLastY, _exclude);
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
            __BentoSetHover(_prevElement, false);
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
                if (_dY < 0)
                {
                    _nextElement = _prevBento.__linkUp;
                }
                else if (_dY > 0)
                {
                    _nextElement = _prevBento.__linkDown;
                }
                else if (_dX < 0)
                {
                    _nextElement = _prevBento.__linkLeft;
                }
                else if (_dX > 0)
                {
                    _nextElement = _prevBento.__linkRight;
                }
            
                //Only check if the next element is properly visible if it's nested inside a different scroller to
                //the previous element. This ensures non-visible elements never get selected but that it's possible
                //to navigate to visually hidden elements inside the scroller.
                var _prevScrollParent = __BentoFindScrollElement(BentoGetParent(1, _prevElement));
                var _checkVisible = (_prevScrollParent != __BentoFindScrollElement(_nextElement));
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
                        __BentoGetDirectionalRaycast(_raycastData, __directionalLastX, __directionalLastY, _dX, _dY, _exclude, _prevScrollParent);
                        
                        //Try wrapping the raycast
                        if ((abs(_dY) >= abs(_dX)) && _prevBento.__raycastWrapY)
                        {
                            var _checkWrap = _prevBento.__raycastWrapY;
                            var _wrapDX = 0;
                            var _wrapDY = _dY;
                        }
                        else if (abs(_dX) > abs(_dY))
                        {
                            var _checkWrap = _prevBento.__raycastWrapX;
                            var _wrapDX = _dX;
                            var _wrapDY = 0;
                        }
                        else
                        {
                            //Should never happen but let's cover our bases
                            var _checkWrap = false;
                        }
                        
                        if (_checkWrap)
                        {
                            //FIXME - 1000 is an arbitrarily large number. This no doubt will fail in some situations
                            __BentoGetDirectionalRaycast(_wrappedRaycastData, __directionalLastX - 1000*_wrapDX, __directionalLastY - 1000*_wrapDY, _wrapDX, _wrapDY, _exclude, _prevScrollParent);
                            if ((_wrappedRaycastData.__weight < _raycastData.__weight) || (_wrappedRaycastData.__sameParent && (not _raycastData.__sameParent)))
                            {
                                _nextElement = _wrappedRaycastData.__element;
                            }
                            else
                            {
                                _nextElement = _raycastData.__element;
                            }
                        }
                        else
                        {
                            _nextElement = _raycastData.__element;
                        }
                        
                        if (not BentoExists(_nextElement))
                        {
                            //Raycast failed, no new element can be selected
                            _nextElement = _prevElement;
                        }
                    }
                }
            }
            
            __BentoSetHover(_nextElement, true);
        }
    }
}