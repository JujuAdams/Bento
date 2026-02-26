// Feather disable all

/// @param [layerOrName=current]

function BentoDebugStepOrder(_layerOrName = undefined)
{
    if (not BENTO_RUNNING_FROM_IDE) return;
    
    with(__BentoLayerEnsure(_layerOrName))
    {
        __BentoEnsureStepOrder();
        
        var _i = 0;
        repeat(array_length(__stepOrder))
        {
            var _self = method_get_self(__stepOrder[_i]);
            
            if (is_instanceof(_self, __BentoClassVariables))
            {
                _self = _self.__attachedElement;
            }
            else if (is_instanceof(_self, __BentoClassScrollbar))
            {
                _self = _self.__element;
            }
            else
            {
                show_debug_message(_self.BENTO_VARS.__elementIsInstance? object_get_name(_self.object_index) : instanceof(_self));
            }
            
            ++_i;
        }
    }
}