// Feather disable all

/// @param [element=self]

function GuiTextGetTargeted(_element = self)
{
    static _system = __GuiSystem();
    
    return (_system.__textHandlerEnvironment != undefined)? (_system.__textHandlerEnvironment.__textElement == _element) : false;
}