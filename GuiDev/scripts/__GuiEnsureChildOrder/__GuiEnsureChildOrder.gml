// Feather disable all

function __GuiEnsureChildOrder()
{
    static _dirtyChildOrderArray = __GuiSystem().__dirtyChildOrderArray;
    
    array_foreach(_dirtyChildOrderArray, __GuiSortChildren);
    array_resize(_dirtyChildOrderArray, 0);
}