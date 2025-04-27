// Feather disable all

var _id = id;

with(GUI_STRUCT)
{
    __GuiRemoveParent(_id);
    GuiDestroyChildren(_id);
    
    if (instance_exists(__selectOnDestroy))
    {
        GuiNavSelectSoft(__selectOnDestroy);
    }
    
    if (__focusable) GuiNavSetFocus(false);
    
    if (__tabIdent != undefined)
    {
        var _tabData = __GuiTabGetData(__tabIdent);
        if ((_tabData.__host == _id) || (_tabData.__button == _id))
        {
            GuiTabClose(__tabIdent);
        }
    }
    
    if (__tabIdentChildOf != undefined)
    {
        var _tabData = __GuiTabGetData(__tabIdentChildOf);
        if (_tabData.__child == _id)
        {
            if (not instance_exists(__selectOnDestroy))
            {
                GuiNavSelect(_tabData.__button);
            }
        }
    }
    
    with(__GuiSystem())
    {
        __layoutDirty = true;
        __stepDirty   = true;
        __drawDirty   = true;
        
        var _instance = __nameMap[? other.__name];
        if (_instance == _id) ds_map_delete(__nameMap, other.__name);
        
        if (__popUpRoot == _id) __popUpRoot = noone;
        
        if (other.__animating)
        {
            other.__animating = false;
            __animCount--;
        }
        
        if (__GUI_DEBUG)
        {
            variable_struct_remove(__debugDict, other.__debugUUID);
        }
    }
}