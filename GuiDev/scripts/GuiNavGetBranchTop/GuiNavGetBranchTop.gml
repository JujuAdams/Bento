// Feather disable all

/// @param [layer=current]

function GuiNavBranchCloseAll(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        return __branchTop;
    }
}