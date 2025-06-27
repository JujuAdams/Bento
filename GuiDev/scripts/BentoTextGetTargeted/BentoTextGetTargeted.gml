// Feather disable all

/// @param [element=self]

function BentoTextGetTargeted(_element = self)
{
    static _system = __BentoSystem();
    
    return (_system.__textHandlerEnvironment != undefined)? (_system.__textHandlerEnvironment.__textElement == _element) : false;
}