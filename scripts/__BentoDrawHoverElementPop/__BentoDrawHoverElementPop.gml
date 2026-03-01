function __BentoDrawHoverElementPop()
{
    static _drawHoverElementStack = __BentoSystem().__drawHoverElementStack;
    
    //FIXME - Store the transform matrix (and offset?) for the hovered element and reapply here
    with(array_pop(_drawHoverElementStack))
    {
        BENTO_VARS.__eventDrawHover();
    }
}