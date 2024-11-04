// Feather disable all

/// @param preDelay
/// @param delay
/// @param count
/// @param shorterDelay

function GuiInputConfigureNavigation(_preDelay, _delay, _count, _shortDelay)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        __gamepadNavPreDelay     = _preDelay;
        __gamepadNavDelay        = _delay;
        __gamepadNavDelayCount   = _count;
        __gamepadNavDelayShorter = _shortDelay;
    }
}