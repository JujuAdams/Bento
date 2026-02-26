// Feather disable all

/// @param [layerOrName=current]

function BentoDebugStepOrder(_layerOrName = undefined)
{
    if (not BENTO_RUNNING_FROM_IDE) return;
    if (BENTO_SHOW_DEBUG_MESSAGE == undefined) return;
    
    with(__BentoLayerEnsure(_layerOrName))
    {
        __BentoEnsureStepOrder();
        
        var _array = [];
        
        var _i = 0;
        repeat(array_length(__stepOrder))
        {
            var _method = __stepOrder[_i];
            var _self   = method_get_self(_method);
            
            if (is_instanceof(_self, __BentoClassVariables))
            {
                var _element = _self.__attachedElement;
                
                if (_method == _self.__eventScissorPush)
                {
                    var _action = "scissor push";
                }
                else if (_method == _self.__eventScissorPop)
                {
                    var _action = "scissor pop";
                }
                else
                {
                    var _action = "<unknown>";
                }
            }
            else if (is_instanceof(_self, __BentoClassScrollbarHori))
            {
                var _element = _self.__element;
                var _action  = "scrollbar (hori)";
            }
            else if (is_instanceof(_self, __BentoClassScrollbarVert))
            {
                var _element = _self.__element;
                var _action  = "scrollbar (vert)";
            }
            else
            {
                var _element = _self;
                var _action  = "step";
            }
            
            if (_element != undefined)
            {
                var _bentoVars = _element.BENTO_VARS;
                
                if (_bentoVars.__elementIsInstance)
                {
                    var _type     = object_get_name(_element.object_index);
                    var _nativeID = string(real(_element.id));
                }
                else
                {
                    var _type     = instanceof(_element);
                    var _nativeID = string_delete(string(ptr(_element)), 1, 8);
                }
            }
            
            array_push(_array, [_bentoVars.__envIndex, _nativeID, _bentoVars.__name ?? "", _type, _action]);
            
            ++_i;
        }
        
        var _function = BENTO_SHOW_DEBUG_MESSAGE;
        _function("Bento: Debugging step order");
        _function(__BentoArray2DToFormattedTable(_array, ["GUID", "Native ID", "Name", "Type", "Action(s)"]));
    }
}