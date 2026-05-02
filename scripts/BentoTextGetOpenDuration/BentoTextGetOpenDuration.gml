// Feather disable all

/// Returns the length of time that text input has been open for the given element. If text input
/// is not targeting the element then this function will return `0`.
/// 
/// @param [element=self]

function BentoTextGetOpenDuration(_element = self)
{
    static _system = __BentoSystem();
    
    if (not BentoExists(_element)) return 0;
    
    var _textHandler = _element.BENTO_VARS.__layer.__environment.__textHandler;
    return (_textHandler == undefined)? 0 : (_system.__frame - _textHandler.__openFrame);
}