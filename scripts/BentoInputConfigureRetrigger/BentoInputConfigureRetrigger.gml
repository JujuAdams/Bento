// Feather disable all

/// Sets the global navigation input retrigger behavior. This is also called "turbo" or "repeat"
/// or "rapid fire" input. The retrigger behavior applies only to up/down/left/right inputs. You
/// can use this function to control two phases of repeating inputs: a slower rate and, after a
/// certain number of triggers, a faster rate.
/// 
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