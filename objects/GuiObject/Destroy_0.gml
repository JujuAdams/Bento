// Feather disable all

__GuiRemoveParent(id);
GuiDestroyChildren(id);

if (instance_exists(__selectOnDestroy))
{
    GuiNavSelectSoft(__selectOnDestroy);
}

with(__tabsHost)
{
    if (__tabsChild == other.id)
    {
        if (not instance_exists(other.__selectOnDestroy))
        {
            GuiNavSelect(__tabsButton);
        }
        
        __tabsButton = noone;
        __tabsChild  = noone;
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