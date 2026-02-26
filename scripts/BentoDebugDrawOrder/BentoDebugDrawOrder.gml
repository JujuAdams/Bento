// Feather disable all

/// @param [layerOrName=current]

function BentoDebugDrawOrder(_layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        __BentoEnsureDrawOrder();
        
        var _i = 0;
        repeat(array_length(__drawOrder))
        {
            var _bentoVars = method_get_self(__drawOrder[_i]);
            show_debug_message(_bentoVars.__elementIsInstance? object_get_name(_bentoVars.__attachedElement.object_index) : instanceof(_bentoVars.__attachedElement));
            ++_i;
        }
    }
}