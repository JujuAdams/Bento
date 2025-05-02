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
    
    if (__tabIdent != undefined)
    {
        var _tabData = __GuiTabGetData(__tabIdent, __environment);
        if ((_tabData.__host == _self) || (_tabData.__button == _self))
        {
            GuiTabClose(__tabIdent);
        }
    }
    
    if (__tabIdentChildOf != undefined)
    {
        var _tabData = __GuiTabGetData(__tabIdentChildOf, __environment);
        if (_tabData.__child == _self)
        {
            if (not GUI_EXISTS(__selectOnDestroy))
            {
                GuiNavSelect(_tabData.__button);
            }
        }
    }
    
    with(__environment)
    {
        __layoutDirty = true;
        __stepDirty   = true;
        __drawDirty   = true;
        
        var _instance = __nameMap[? other.__name];
        if (_instance == _self) ds_map_delete(__nameMap, other.__name);
        
        if (__popUpRoot == _self) __popUpRoot = noone;
    }
}