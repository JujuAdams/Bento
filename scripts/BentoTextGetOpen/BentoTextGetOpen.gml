// Feather disable all

/// Returns if text input is open. This is a global value and will return `true` if any text input
/// is active across any environment.

function BentoTextGetOpen()
{
    static _system = __BentoSystem();
    return (_system.__textHandlerEnvironment != undefined);
}