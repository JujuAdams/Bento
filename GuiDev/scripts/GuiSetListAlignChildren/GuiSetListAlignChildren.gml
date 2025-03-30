// Feather disable all

/// @param [horizontal]
/// @param [vertical]
/// @param [instance=id]

function GuiSetListAlignChildren(_horizontal, _vertical, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (not variable_instance_exists(id, "__alignChildrenH"))
        {
            __GuiError("Can only set list child alignment on objects that inherit from `oGuiLibList`");
        }
        
        if (_horizontal != undefined)
        {
            if (__alignChildrenH != _horizontal)
            {
                __alignChildrenH = _horizontal;
                _system.__layoutDirty = true;
            }
        }
        
        if (_vertical != undefined)
        {
            if (__alignChildrenV != _vertical)
            {
                __alignChildrenV = _vertical;
                _system.__layoutDirty = true;
            }
        }
    }
}