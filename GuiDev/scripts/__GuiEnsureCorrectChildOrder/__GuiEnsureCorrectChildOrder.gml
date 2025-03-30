// Feather disable all

function __GuiEnsureCorrectChildOrder()
{
    static _dirtyOrderArray = __GuiSystem().__dirtyOrderArray;
    
    array_foreach(_dirtyOrderArray, __GuiSortChildren);
    array_resize(_dirtyOrderArray, 0);
}