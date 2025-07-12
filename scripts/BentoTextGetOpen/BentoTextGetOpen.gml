// Feather disable all

/// Returns if text input is open.
/// 
/// @param [element=self]

function BentoTextGetOpen(_element = self)
{
    static _system = __BentoSystem();
    return (_system.__textHandlerEnvironment != undefined);
}