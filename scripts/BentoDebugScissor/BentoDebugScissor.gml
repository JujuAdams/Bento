// Feather disable all

/// @param [layerOrName=current]

function BentoDebugScissor(_layerOrName = undefined)
{
    if (not BENTO_RUNNING_FROM_IDE) return;
    if (BENTO_SHOW_DEBUG_MESSAGE == undefined) return;
    
    with(__BentoLayerEnsure(_layerOrName))
    {
        var _array = [];
        
        if (BentoExists(__rootElement))
        {
            __BentoDebugScissorInner(__rootElement.BENTO_VARS, _array)
        }
        
        var _function = BENTO_SHOW_DEBUG_MESSAGE;
        _function("Bento: Debugging scissor");
        _function(__BentoArray2DToFormattedTable(_array, ["", "GUID", "Native ID", "Name", "Type", "Scissor ID"]));
    }
}

function __BentoDebugScissorInner(_bentoVars, _array)
{
    var _funcName = function(_element)
    {
        var _result = {
            __type: "",
            __name: "",
            __nativeID: "",
        };
        
        with(__BentoGetVars(_element))
        {
            _result.__name = __name ?? "";
            
            if (__elementIsInstance)
            {
                _result.__type     = object_get_name(__attachedElement.object_index);
                _result.__nativeID = string(real(__attachedElement.id));
            }
            else
            {
                _result.__type     = instanceof(__attachedElement);
                _result.__nativeID = __BentoGetStructPointer(__attachedElement);
            }
        }
        
        return _result;
    }
    
    with(_bentoVars)
    {
        var _ourNameData    = _funcName(__attachedElement);
        var _parentNameData = _funcName(__scissorParent.__attachedElement);
        
        array_push(_array, [__scissorEnabled? "scissor push" : "", __envIndex, _ourNameData.__nativeID, _ourNameData.__name, _ourNameData.__type, _parentNameData.__nativeID]);
        
        var _i = 0;
        repeat(array_length(__childArray))
        {
            __BentoDebugScissorInner(__childArray[_i], _array);
            ++_i;
        }
        
        if (__scissorEnabled)
        {
            array_push(_array, ["scissor pop", __envIndex, _ourNameData.__nativeID, _ourNameData.__name, _ourNameData.__type, _parentNameData.__nativeID]);
        }
    }
}