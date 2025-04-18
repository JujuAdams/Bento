// Feather disable all

function __GuiEnsureCorrectChildOrder()
{
    static _dirtyPriorityArray = __GuiSystem().__dirtyPriorityArray;
    
    array_foreach(_dirtyPriorityArray, __GuiSortChildren);
    array_resize(_dirtyPriorityArray, 0);
}