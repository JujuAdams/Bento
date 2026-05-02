// Feather disable all

/// @param [layerOrName=current]

function BentoDebugDrawOrder(_layerOrName = undefined)
{
    static _functionDrawLookupMap = __BentoSystem().__functionDrawLookupMap;;
    
    if (not BENTO_RUNNING_FROM_IDE) return;
    if (BENTO_SHOW_DEBUG_MESSAGE == undefined) return;
    
    with(__BentoLayerEnsure(_layerOrName))
    {
        __BentoEnsureDrawOrder();
        
        var _array = [];
        
        var _i = 0;
        repeat(array_length(__drawOrder))
        {
            var _method = __drawOrder[_i];
            
            var _bentoVars = method_get_self(_method);
            var _function  = method_get_index(_method);
            
            if (_bentoVars.__elementIsInstance)
            {
                var _type     = object_get_name(_bentoVars.__attachedElement.object_index);
                var _nativeID = string(real(_bentoVars.__attachedElement.id));
            }
            else
            {
                var _type     = instanceof(_bentoVars.__attachedElement);
                var _nativeID = __BentoGetStructPointer(_bentoVars.__attachedElement);
            }
            
            var _action = _functionDrawLookupMap[? _function] ?? "<unknown>";
            
            array_push(_array, [_bentoVars.__envIndex, _nativeID, _bentoVars.__name ?? "", _type, _action]);
            
            ++_i;
        }
        
        var _function = BENTO_SHOW_DEBUG_MESSAGE;
        _function("Bento: Debugging draw order");
        _function(__BentoArray2DToFormattedTable(_array, ["GUID", "Native ID", "Name", "Type", "Action(s)"]));
    }
}