// Feather disable all

/// @param [element=self]

function GuiTextGetOpenDuration(_element = self)
{
    static _system = __GuiSystem();
    
    if (not GuiExists(_element)) return 0;
    
    var _textHandler = _element.GUI_VARS.__layer.__environment.__textHandler;
    return (_textHandler == undefined)? 0 : (_system.__frame - _textHandler.__openFrame);
}