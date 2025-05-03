// Feather disable all

/// @param element
/// @param clickDimiss

function GuiNavBranchOpen(_element, _clickDimiss)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (not __branched)
        {
            __branched = true;
            
            var _branchStack = __layer.__branchStack;
            
            //Search for a branching point
            var _i = array_length(_branchStack)-1;
            if (_i >= 0)
            {
                var _branchElement = undefined;
                repeat(array_length(_branchStack))
                {
                    if (GuiIsAncestor(_branchStack[_i], _element))
                    {
                        _branchElement = _branchStack[_i];
                        break;
                    }
                    
                    --_i;
                }
                
                GuiNavBranchClose(_branchElement);
            }
            
            array_push(_branchStack, _element);
            __layer.__branchTop = _element;
        }
        
        __branchClickDismiss = _clickDimiss;
    }
}