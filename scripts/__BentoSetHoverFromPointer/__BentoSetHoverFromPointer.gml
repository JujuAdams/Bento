// Feather disable all

function __BentoSetHoverFromPointer(_mouseX, _mouseY)
{
    //Can't hover anything when there are blocking animations on this layer.
    if (not ds_map_empty(__animBlockingMap))
    {
        __BentoSetHover(BENTO_NO_ELEMENT, false);
        return;
    }
    
    var _hoverableOrder = __hoverableOrder;
    var _hoverableCount = array_length(_hoverableOrder);
    
    if (not __inputModePointer)
    {
        __BentoError("Can only use `__BentoSetHoverFromPointer()` in pointer mode");
    }
    
    var _holdElement = __holdElement;
    
    var _i = 0;
    repeat(_hoverableCount)
    {
        var _result = _hoverableOrder[_i](_mouseX, _mouseY, _holdElement);
        if (_result != undefined)
        {
            __BentoSetHover(_result, true);
            return;
        }
        
        ++_i;
    }
    
    __BentoSetHover(BENTO_NO_ELEMENT, false);
}