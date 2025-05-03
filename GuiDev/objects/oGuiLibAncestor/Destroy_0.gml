// Feather disable all

var _self = self;

with(GUI_VARS)
{
    __GuiRemoveParent(_self);
    GuiDestroyChildren(_self);
    
    if (GUI_EXISTS(__selectOnDestroy))
    {
        GuiNavSelectSoft(__selectOnDestroy);
    }
    
    if (__focusable) GuiNavSetFocus(false);
    
    with(__layer)
    {
        __layoutDirty = true;
        __stepDirty   = true;
        __drawDirty   = true;
        
        var _instance = __nameMap[? other.__name];
        if (_instance == _self) ds_map_delete(__nameMap, other.__name);
        
        if (__popUpRoot == _self) __popUpRoot = noone;
    }
}