// Feather disable all

/// @param [layerOrName=current]

function BentoDebugDrawOrder(_layerOrName = undefined)
{
    static _functionDrawLookupMap = __BentoSystem().__functionDrawLookupMap;;
    
    if (not BENTO_RUNNING_FROM_IDE) return;
    
    with(__BentoLayerEnsure(_layerOrName))
    {
        __BentoEnsureDrawOrder();
        
        var _i = 0;
        repeat(array_length(__drawOrder))
        {
            var _method = __drawOrder[_i];
            
            var _bentoVars = method_get_self(_method);
            var _function  = method_get_index(_method);
            
            if (_bentoVars.__elementIsInstance)
            {
                var _name = object_get_name(_bentoVars.__attachedElement.object_index);
                var _id   = string(real(_bentoVars.__attachedElement.id));
            }
            else
            {
                var _name = instanceof(_bentoVars.__attachedElement);
                var _id   = string_delete(string(ptr(_bentoVars.__attachedElement)), 1, 8);
            }
            
            var _eventName = _functionDrawLookupMap[? _function] ?? "<unknown method>";
            
            show_debug_message($"{string_format(_bentoVars.__envIndex, 4, 0)}:{_name} ({_id})    {_eventName}");
            
            ++_i;
        }
    }
}