// Feather disable all

/// Returns which instance is highlighted using the directional input highlighting rules. This
/// function can return `GUI_NO_ELEMENT` if no instance is available to highlight. This function should
/// only be called if we're using directional (keyboard and gamepad) input.
/// 
/// @param startInstance
/// @param dX
/// @param dY

function __GuiGetDirectionalOver(_prevElement, _dX, _dY)
{
    static _excludeArray = [];
    
    _excludeArray[0] = _prevElement;
    var _nextElement = GUI_NO_ELEMENT;
    
    if (not GuiGetHoverable(_prevElement, false))
    {
        //The instance we were previously highlighting is no longer valid (see GuiGetHoverable())
        
        if (GuiGetHoverable(__overElementSoft, false))
        {
            //Choose the soft selection if possible
            _nextElement = __overElementSoft;
        }
        else
        {
            //Otherwise fall back on searching for the nearest selectable instance
            _nextElement = __GuiGetNearest(__directionalLastX, __directionalLastY, _excludeArray);
        }
    }
    else
    {
        var _prevGui = _prevElement.GUI_VARS;
        
        //Previously selected instance is valid, process navigation
        if ((_dX == 0) && (_dY == 0))
        {
            //No movement, keep the same instance we had before
            _nextElement = _prevElement;
        }
        else
        {
            //Don't allow selection of the next instance if we're not visible
            if (not GuiClipGetVisible(false, _prevElement))
            {
                GuiScrollTo(GuiScrollGetSpeed(_prevElement), _prevElement);
                return _prevElement;
            }
            
            //Choose a predefined navigable instance if possible
            if (_dX < 0)
            {
                _nextElement = _prevGui.__linkLeft;
            }
            else if (_dX > 0)
            {
                _nextElement = _prevGui.__linkRight;
            }
            else if (_dY < 0)
            {
                _nextElement = _prevGui.__linkUp;
            }
            else if (_dY > 0)
            {
                _nextElement = _prevGui.__linkDown;
            }
            
            //Only check if the next instance is properly visible if it's nested inside a different scroller to
            //the previous instance. This ensures non-visible instances never get selected but that it's possible
            //to navigate to visually hidden instances inside the scroller.
            var _prevScrollParent = __GuiScrollFindParent(_prevElement);
            //FIXME - This should be the joint scissor and scroll parent
            if (not GuiGetHoverable(_nextElement, (_prevScrollParent != __GuiScrollFindParent(_nextElement))))
            {
                _nextElement = GUI_NO_ELEMENT;
            }
            
            if (not GuiExists(_nextElement))
            {
                //If the navigation instance isn't selectable then fall back on a raycast
                
                if (((_dX != 0) && _prevGui.__raycastDisableHori) || ((_dY != 0) && _prevGui.__raycastDisableVert))
                {
                    //Raycast is disabled for the previous instance!
                    _nextElement = _prevElement;
                }
                else
                {
                    _nextElement = __GuiGetRaycast(__directionalLastX, __directionalLastY, _dX, _dY, _excludeArray, _prevScrollParent);
                    
                    if (not GuiExists(_nextElement))
                    {
                        //Raycast failed, no new instance can be selected
                        _nextElement = _prevElement;
                    }
                }
            }
        }
    }
    
    return _nextElement;
}