/// Forcibly sets the input mode for Bento.
/// 
/// The mode should be one of the following constants:
///   BENTO_INPUT_MODE_POINTER
///   BENTO_INPUT_MODE_DIRECTIONAL
/// 
/// @param mode

function BentoInputSetMode(_mode)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputSetMode(_mode);
}