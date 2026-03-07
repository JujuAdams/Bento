// Feather disable all

/// Returns the global scaling factor applied to Bento elements.

function BentoSystemGetScale()
{
    static _system = __BentoSystem();
    
    return _system.__globalScale;
}