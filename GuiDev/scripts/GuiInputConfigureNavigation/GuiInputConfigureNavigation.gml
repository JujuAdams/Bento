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
        __globalNavDirPreDelay     = _preDelay;
        __globalNavDirDelay        = _delay;
        __globalNavDirDelayCount   = _count;
        __globalNavDirDelayShorter = _shortDelay;
    }
}