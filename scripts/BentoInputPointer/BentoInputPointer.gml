/// Sets the world-space position of Bento's internal pointer.
/// 
/// This function also implicitly sets the BENTO_INPUT_MODE_POINTER input mode.

function BentoInputPointer(_x, _y)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputPointer(_x, _y);
}