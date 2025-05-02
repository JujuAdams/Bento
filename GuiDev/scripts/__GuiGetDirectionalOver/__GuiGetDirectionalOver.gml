// Feather disable all

/// Returns which instance is highlighted using the directional input highlighting rules. This
/// function can return `noone` if no instance is available to highlight. This function should
/// only be called if we're using directional (keyboard and gamepad) input.
/// 
/// @param startInstance
/// @param dX
/// @param dY

function __GuiGetDirectionalOver(_prevInstance, _dX, _dY)
{
    static _excludeArray = [];
    
    _excludeArray[0] = _prevInstance;
    var _nextInstance = noone;
    
    if (not GuiGetHoverable(_prevInstance, false))
    {
        //The instance we were previously highlighting is no longer valid (see GuiGetHoverable())
        
        if (GuiGetHoverable(__overInstanceSoft, false))
        {
            //Choose the soft selection if possible
            _nextInstance = __overInstanceSoft;
        }
        else
        {
            //Otherwise fall back on searching for the nearest selectable instance
            _nextInstance = GuiNavGetNearest(__directionalLastX, __directionalLastY, _excludeArray);
        }
    }
    else
    {
        var _prevGui = _prevInstance.GUI_VARS;
        
        //Previously selected instance is valid, process navigation
        if ((_dX == 0) && (_dY == 0))
        {
            //No movement, keep the same instance we had before
            _nextInstance = _prevInstance;
        }
        else
        {
            //Don't allow selection of the next instance if we're not visible
            if (not GuiGetVisibleInScroll(false, _prevInstance))
            {
                GuiScrollTo(GuiScrollGetSpeed(_prevInstance), _prevInstance);
                return _prevInstance;
            }
            
            //Choose a predefined navigable instance if possible
            if (_dX < 0)
            {
                _nextInstance = _prevGui.__navLeft;
            }
            else if (_dX > 0)
            {
                _nextInstance = _prevGui.__navRight;
            }
            else if (_dY < 0)
            {
                _nextInstance = _prevGui.__navUp;
            }
            else if (_dY > 0)
            {
                _nextInstance = _prevGui.__navDown;
            }
            
            //Only check if the next instance is properly visible if it's nested inside a different scroller to
            //the previous instance. This ensures non-visible instances never get selected but that it's possible
            //to navigate to visually hidden instances inside the scroller.
            var _prevScrollParent = __GuiScrollFindParent(_prevInstance);
            if (not GuiGetHoverable(_nextInstance, (_prevScrollParent != __GuiScrollFindParent(_nextInstance))))
            {
                _nextInstance = noone;
            }
            
            if (not instance_exists(_nextInstance))
            {
                //If the navigation instance isn't selectable then fall back on a raycast
                
                if (((_dX != 0) && _prevGui.__raycastDisableHori) || ((_dY != 0) && _prevGui.__raycastDisableVert))
                {
                    //Raycast is disabled for the previous instance!
                    _nextInstance = _prevInstance;
                }
                else
                {
                    _nextInstance = GuiNavGetRaycast(__directionalLastX, __directionalLastY, _dX, _dY, _excludeArray, _prevScrollParent);
                    
                    if (not instance_exists(_nextInstance))
                    {
                        //Raycast failed, no new instance can be selected
                        _nextInstance = _prevInstance;
                    }
                }
            }
        }
    }
    
    return _nextInstance;
}