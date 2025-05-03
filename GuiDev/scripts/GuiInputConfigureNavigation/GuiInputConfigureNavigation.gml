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
        __globalDirPreDelay     = _preDelay;
        __globalDirDelay        = _delay;
        __globalDirDelayCount   = _count;
        __globalDirDelayShorter = _shortDelay;
    }
}