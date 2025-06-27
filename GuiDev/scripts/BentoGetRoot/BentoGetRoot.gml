// Feather disable all

/// Returns the root instance. This should always exist! If it doesn't then something very bad has
/// happened and this function will throw an error accordingly.
/// 
/// @param [layer=current]

function BentoGetRoot(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (not BentoExists(__rootElement))
        {
            __rootElement = new BentoConstrAncestor(undefined);
            __rootElement.BENTO_VARS.__layer = self;
        }
        
        return __rootElement;
    }
}