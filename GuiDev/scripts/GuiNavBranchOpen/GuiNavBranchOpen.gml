// Feather disable all

/// @param branchType
/// @param [element=self]

function GuiNavBranchOpen(_branchType, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        var _layer = __layer;
        
        __branchType = _branchType;
        
        //If the player is using a pointer but we want to always cancel branching when using a pointer
        //then sort that out
        if (_layer.__navPointer && (_branchType == GUI_BRANCH_POINTER_CANCEL_ALWAYS))
        {
            GuiNavBranchClose(_element);
            return;
        }
        
        if (not __branched)
        {
            __branched = true;
            _layer.__stepDirty = true;
            
            var _branchStack = __layer.__branchStack;
            
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
            _layer.__branchTop = _element;
            
            if (__scissorEnabled)
            {
                _layer.__directionalLastX = _element.guiLeft + __scissorPadLeft;
                _layer.__directionalLastY = _element.guiTop  + __scissorPadTop;
            }
            else
            {
                _layer.__directionalLastX = _element.guiLeft;
                _layer.__directionalLastY = _element.guiTop;
            }
        }
    }
}