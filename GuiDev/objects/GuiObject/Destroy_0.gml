// Feather disable all

__GuiRemoveParent(id);
GuiDestroyChildren(id);

if (instance_exists(__selectOnDestroy))
{
    GuiNavSelectSoft(__selectOnDestroy);
}

if (__focusable) GuiNavSetFocus(false);

if (__tabIdent != undefined)
{
    var _tabData = __GuiTabGetData(__tabIdent);
    if ((_tabData.__host == id) || (_tabData.__button == id))
    {
        GuiTabClose(__tabIdent);
    }
}

if (__tabIdentChildOf != undefined)
{
    var _tabData = __GuiTabGetData(__tabIdentChildOf);
    if (_tabData.__child == id)
    {
        if (not instance_exists(__selectOnDestroy))
        {
            GuiNavSelect(_tabData.__button);
        }
    }
}

with(__GuiSystem())
{
    __stepDirty = true;
    __drawDirty = true;
    
    var _instance = __nameMap[? other.__name];
    if (_instance == other.id) ds_map_delete(__nameMap, other.__name);
    
    if (__popUpRoot == other.id) __popUpRoot = noone;
    
    if (other.__animating)
    {
        other.__animating = false;
        __animCount--;
    }
}