function __BentoDrawHoverElementPush()
{
    static _drawHoverElementStack = __BentoSystem().__drawHoverElementStack;
    
    array_push(_drawHoverElementStack, BENTO_NO_ELEMENT);
}