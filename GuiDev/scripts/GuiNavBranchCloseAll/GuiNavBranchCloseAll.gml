// Feather disable all

/// @param [layer=current]

function GuiNavBranchCloseAll(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        var _branchStack = __layer.__branchStack;
        if (array_length(_branchStack) > 0)
        {
            __layer.__stepDirty = true;
            
            var _i = 0;
            repeat(array_length(_branchStack))
            {
                _branchStack[_i].__branched = false;
                ++_i;
            }
            
            array_resize(_branchStack, 0);
            __layer.__branchTop = undefined;
        }
    }
}