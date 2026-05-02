// Feather disable all

/// Returns the root element for the layer.
/// 
/// @param [layerOrName=current]

function BentoLayerGetRoot(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (not BentoExists(__rootElement))
        {
            __rootElement = new BentoConstrAncestor(__BENTO_NO_PARENT);
            __rootElement.BENTO_VARS.__layer = self;
        }
        
        return __rootElement;
    }
    
    return BENTO_NO_ELEMENT;
}