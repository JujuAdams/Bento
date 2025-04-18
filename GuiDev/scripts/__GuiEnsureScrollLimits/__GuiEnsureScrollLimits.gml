// Feather disable all

function __GuiEnsureScrollLimits()
{
    static _dirtyScrollLimitsArray = __GuiSystem().__dirtyScrollLimitsArray;
    
    array_foreach(_dirtyScrollLimitsArray, __GuiUpdateScrollLimits);
    array_resize(_dirtyScrollLimitsArray, 0);
}