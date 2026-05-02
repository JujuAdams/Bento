// Feather disable all

/// Returns how many steps have elapsed since the game started. This number will increase even if
/// `BentoSystemStep()` is not called in a frame.

function BentoSystemGetTime()
{
    static _system = __BentoSystem();
    
    return _system.__frame;
}