/// Pushes Bento's internal pointer in a direction until it hits a box that can be highlighted.
/// 
/// This function can be used in conjunction with gamepad thumbstick input to create a navigable
/// interface. It can also be used with keyboard input though, due to the limited directions that
/// can be expressed with keyboard input, care should be taken to ensure the whole interface is
/// navigable with only 4-directional movement.
/// 
/// This function also implicitly sets the BENTO_INPUT_MODE_DIRECTIONAL input mode.
/// 
/// @param dX
/// @param dY
/// @param [retrigger=false]
/// @param [threshold=0.2]
/// @param [excludeGroup=false]

function BentoInputDirection(_dX, _dY, _retrigger = false, _threshold = 0.2, _excludeGroup = false)
{
    static _global = __BentoGlobal();
    return _global.__currentHost.__InputDirection(_dX, _dY, _retrigger, _threshold, _excludeGroup);
}