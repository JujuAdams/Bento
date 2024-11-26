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
        __directionalNavPreDelay     = _preDelay;
        __directionalNavDelay        = _delay;
        __directionalNavDelayCount   = _count;
        __directionalNavDelayShorter = _shortDelay;
    }
}