// Feather disable all

/// Handles scrolling behavior when using the `BENTO_MODE_MOUSE` or `BENTO_MODE_TOUCH` navigation modes.
/// This function should be called in the Step user event (`BENTO_USER_EVENT_STEP`) for both the
/// parent and any children.

function __BentoScrollOnPointer()
{
    var _layer = BENTO_VARS.__layer;
    if (_layer.__navPointer)
    {
        if ((BENTO_SCROLL_ON_MOUSE_DRAG || (_layer.__navMode == BENTO_MODE_TOUCH)) && BentoPrimaryGetHold(self))
        {
            with(BENTO_VARS)
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
            
            if (BentoPrimaryGetDragDistance() > BENTO_SCROLL_THRESHOLD)
            {
                var _parent = __BentoScrollFindParent(self);
                if (self == _parent)
                {
                    BentoScrollMove(BentoCursorGetDX(), BentoCursorGetDY(), infinity, _parent);
                }
                else
                {
                    __BentoStartHold(_parent);
                }
            }
        }
        else if (BentoCursorGetHover(self))
        {
            //Mouse wheel input can be pretty noisy so we filter out as much as possible
            
            var _dX = 0;
            var _dY = 0;
            
            if (BentoHotkeyGetPress(BENTO_HOTKEY_MOUSE_WHEEL_UP) || BentoHotkeyGetHold(BENTO_HOTKEY_MOUSE_WHEEL_UP))
            {
                _dX -= BENTO_MOUSE_WHEEL_SCROLL_SPEED;
                _dY += BENTO_MOUSE_WHEEL_SCROLL_SPEED;
            }
            
            if (BentoHotkeyGetPress(BENTO_HOTKEY_MOUSE_WHEEL_DOWN) || BentoHotkeyGetHold(BENTO_HOTKEY_MOUSE_WHEEL_DOWN))
            {
                _dX += BENTO_MOUSE_WHEEL_SCROLL_SPEED;
                _dY -= BENTO_MOUSE_WHEEL_SCROLL_SPEED;
            }
            
            if ((_dX != 0) || (_dY != 0))
            {
                BentoScrollMove(_dX, _dY, BENTO_DEFAULT_SCROLL_SPEED, self);
            }
        }
    }
}