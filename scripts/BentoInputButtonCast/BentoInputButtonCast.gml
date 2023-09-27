/// Sets a "button cast" input state.
/// 
/// This function should be given the "held" state of the user input in question. For example:
/// 
///   BentoInputButtonTarget("quit", keyboard_check(vk_escape));
/// 
/// Bento will take care of the press/released state itself.

function BentoInputButtonCast(_name, _state)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputButtonCast(_name, _state);
}