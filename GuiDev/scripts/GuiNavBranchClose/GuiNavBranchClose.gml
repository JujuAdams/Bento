// Feather disable all

/// @param element

function GuiNavBranchClose(_element)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__branched)
        {
            __layer.__stepDirty = true;
            
            var _branchStack = __layer.__branchStack;
            
            var _index = array_get_index(_branchStack, _element);
            var _i = array_length(_branchStack)-1;
            repeat(array_length(_branchStack) - _index)
            {
                _branchStack[_i].GUI_VARS.__branched = false;
                --_i;
            }
            
            array_delete(_branchStack, _index, array_length(_branchStack) - _index);
            __layer.__branchTop = array_last(_branchStack);
        }
    }
}