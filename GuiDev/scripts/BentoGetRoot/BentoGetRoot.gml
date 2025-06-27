// Feather disable all

/// Returns the root element for the layer.
/// 
/// @param [layerOrName=current]

function BentoGetRoot(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (not BentoExists(__rootElement))
        {
            __rootElement = new BentoConstrAncestor(undefined);
            __rootElement.BENTO_VARS.__layer = self;
        }
        
        return __rootElement;
    }
    
    return BENTO_NO_ELEMENT;
}