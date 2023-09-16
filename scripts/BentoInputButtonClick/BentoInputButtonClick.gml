/// Sets a "button click" input state.
/// 
/// This function should be given the "held" state of the user input in question. For example:
/// 
///   BentoInputButtonClick("action", mouse_check_button(mb_left));
/// 
/// Bento will take care of the press/released state itself.

function BentoInputButtonClick(_name, _state)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputButtonClick(_name, _state);
}