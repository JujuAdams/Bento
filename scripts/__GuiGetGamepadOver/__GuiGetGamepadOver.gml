// Feather disable all

/// @param startInstance
/// @param dX
/// @param dY

function __GuiGetGamepadOver(_prevInstance, _dX, _dY)
{
    static _system       = __GuiSystem();
    static _excludeArray = [];
    
    _excludeArray[0] = _prevInstance;
    var _nextInstance = noone;
    
    if (not __GuiGetSelectableByGamepad(_prevInstance))
    {
        //The instance we were previously highlighting is no longer valid (see __GuiGetSelectableByGamepad())
        
        if (__GuiGetSelectableByGamepad(_system.__overInstanceSoft))
        {
            //Choose the soft selection if possible
            _nextInstance = _system.__overInstanceSoft;
        }
        else
        {
            //Otherwise fall back on searching for the nearest selectable instance
            _nextInstance = GuiNavGetNearest(_system.__gamepadLastX, _system.__gamepadLastY, _excludeArray);
        }
    }
    else
    {
        //Previously selected instance is valid, process navigation
        
        if ((_dX == 0) && (_dY == 0))
        {
            //No movement, keep the same instance we had before
            _nextInstance = _prevInstance;
        }
        else
        {
            //Choose a predefined navigable instance if possible
            if (_dX < 0)
            {
                _nextInstance = _prevInstance.navLeft;
            }
            else if (_dX > 0)
            {
                _nextInstance = _prevInstance.navRight;
            }
            else if (_dY < 0)
            {
                _nextInstance = _prevInstance.navUp;
            }
            else if (_dY > 0)
            {
                _nextInstance = _prevInstance.navDown;
            }
            
            if (not __GuiGetSelectableByGamepad(_nextInstance))
            {
                //If the navigation instance isn't selectable then fall back on a raycast
                
                if (_prevInstance.__raycastDisabled)
                {
                    //Raycast is disabled for the previous instance!
                    _nextInstance = _prevInstance;
                }
                else
                {
                    _nextInstance = GuiNavGetRaycast(_system.__gamepadLastX, _system.__gamepadLastY, _dX, _dY, _excludeArray);
                    
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