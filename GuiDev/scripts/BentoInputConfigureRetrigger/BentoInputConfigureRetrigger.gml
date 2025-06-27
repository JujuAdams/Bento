// Feather disable all

/// @param preDelay
/// @param delay
/// @param count
/// @param shorterDelay

function BentoInputConfigureRetrigger(_preDelay, _delay, _count, _shortDelay)
{
    static _system = __BentoSystem();
    with(_system)
    {
        __globalDirPreDelay     = _preDelay;
        __globalDirDelay        = _delay;
        __globalDirDelayCount   = _count;
        __globalDirDelayShorter = _shortDelay;
    }
}