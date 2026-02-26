// Feather disable all

/// Returns if text input is open. This is a global value and will return `true` if any text input
/// is active across any environment.
/// 
/// @param [element=self]

function BentoTextGetOpen(_element = self)
{
    static _system = __BentoSystem();
    return (_system.__textHandlerEnvironment != undefined);
}