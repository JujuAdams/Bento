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
            __rootElement = new BentoConstrAncestor(__BENTO_NO_PARENT);
            __rootElement.BENTO_VARS.__layer = self;
            BentoNameSet("__layerRoot__", __rootElement);
        }
        
        return __rootElement;
    }
    
    return BENTO_NO_ELEMENT;
}