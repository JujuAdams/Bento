// Feather disable all

function __BentoDrawScissorPushFromVars()
{
    //TODO - Pass the current scissor element into child elements so we can draw highlights more efficiently
    
    var _element = __attachedElement
    
    var _left    = _element.bentoLeft   + __scissorPadLeft   + __scissorScrollbarLeft;
    var _top     = _element.bentoTop    + __scissorPadTop    + __scissorScrollbarTop;
    var _right   = _element.bentoRight  - __scissorPadRight  - __scissorScrollbarRight;
    var _bottom  = _element.bentoBottom - __scissorPadBottom - __scissorScrollbarBottom;
    
    if (__transformMatrix != undefined)
    {
        var _x = (__transformOriginX == undefined)? _element.bentoX : (_left + __transformOriginX);
        var _y = (__transformOriginY == undefined)? _element.bentoY : (_top  + __transformOriginY);
        _left   = __transformScaleX*(_left   - _x) + _x + __transformOffsetX;
        _top    = __transformScaleY*(_top    - _y) + _y + __transformOffsetY;
        _right  = __transformScaleX*(_right  - _x) + _x + __transformOffsetX;
        _bottom = __transformScaleY*(_bottom - _y) + _y + __transformOffsetY;
    }
    
    __BentoDrawScissorPush(_left, _top, _right, _bottom);
}