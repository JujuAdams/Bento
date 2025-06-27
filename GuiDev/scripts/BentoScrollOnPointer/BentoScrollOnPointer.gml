// Feather disable all

/// Handles scrolling behavior when using the `GUI_MODE_MOUSE` or `GUI_MODE_TOUCH` navigation modes.
/// This function should be called in the Step user event (`GUI_USER_EVENT_STEP`) for both the
/// parent and any children.
/// 
/// @param [scrollSpeed]
/// @param [element=self]

function BentoScrollOnPointer(_scrollSpeed = GUI_DEFAULT_SCROLL_SPEED, _element = self)
{
    if (not BentoExists(_element)) return;
    
    var _layer = _element.GUI_VARS.__layer;
    if (_layer.__navPointer)
    {
        if ((GUI_SCROLL_ON_MOUSE_DRAG || (_layer.__navMode == GUI_MODE_TOUCH)) && BentoPrimaryGetHold(_element))
        {
            with(_element.GUI_VARS)
            {
                var _pressX = __layer.__mousePressX;
                var _pressY = __layer.__mousePressY;
                
                with(__scrollbarVert)
                {
                    if (point_in_rectangle(_pressX, _pressY, barLeft, barTop, barRight, barBottom))
                    {
                        return;
                    }
                }
                
                with(__scrollbarHori)
                {
                    if (point_in_rectangle(_pressX, _pressY, barLeft, barTop, barRight, barBottom))
                    {
                        return;
                    }
                }
            }
            
            if (BentoPrimaryGetDragDistance() > GUI_SCROLL_THRESHOLD)
            {
                var _parent = __BentoScrollFindParent(_element);
                if (_element == _parent)
                {
                    BentoScrollMove(BentoCursorGetDX(), BentoCursorGetDY(), infinity, _parent);
                }
                else
                {
                    __BentoStartHold(_parent);
                }
            }
        }
        else if (BentoCursorGetHover(_element))
        {
            //Mouse wheel input can be pretty noisy so we filter out as much as possible
            
            var _dX = 0;
            var _dY = 0;
            
            if (BentoHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_UP) || BentoHotkeyGetHold(GUI_HOTKEY_MOUSE_WHEEL_UP))
            {
                _dX -= GUI_MOUSE_WHEEL_SCROLL_SPEED;
                _dY += GUI_MOUSE_WHEEL_SCROLL_SPEED;
            }
            
            if (BentoHotkeyGetPress(GUI_HOTKEY_MOUSE_WHEEL_DOWN) || BentoHotkeyGetHold(GUI_HOTKEY_MOUSE_WHEEL_DOWN))
            {
                _dX += GUI_MOUSE_WHEEL_SCROLL_SPEED;
                _dY -= GUI_MOUSE_WHEEL_SCROLL_SPEED;
            }
            
            BentoScrollMove(_dX, _dY, _scrollSpeed, _element);
        }
    }
}