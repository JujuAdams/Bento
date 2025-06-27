// Feather disable all

/// Returns which element is highlighted using the mouse & touch highlighting rules. This function
/// can return `BENTO_NO_ELEMENT` if no element is highlighted.

function __BentoGetPointerHover(_mouseX, _mouseY)
{
    var _hoverableOrder = __hoverableOrder;
    var _hoverableCount = array_length(_hoverableOrder);
    
    if (not __navPointer)
    {
        __BentoError("Can only use `__BentoGetPointerHover()` in pointer mode");
    }
    
    var _holdElement = __holdElement;
    
    var _i = _hoverableCount-1;
    repeat(_hoverableCount)
    {
        var _result = _hoverableOrder[_i](_mouseX, _mouseY, _holdElement);
        if (_result != undefined)
        {
            return _result;
        }
        
        --_i;
    }
}