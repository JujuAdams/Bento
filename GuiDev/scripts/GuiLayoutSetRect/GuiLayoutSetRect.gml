// Feather disable all

/// @param [element=self]

function GuiLayoutSetRect(_element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_RECT)
        {
            //Swapping into rect layout, reset everything
            
            __layoutType = GUI_LAYOUT_RECT;
            __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            
            __SolverGetShrinkWidth  = method(self, __GuiSolverRectGetShrinkWidth);
            __SolverResizeWidth  = function() {}
            __SolverGetShrinkHeight = method(self, __GuiSolverRectGetShrinkHeight);
            __SolverResizeHeight = function() {}
            __SolverPositions    = method(self, __GuiSolverRectPositions);
            __funcMeasureWidth   = function() { return 1; }
            __funcMeasureHeight  = function() { return 1; }
        }
    }
}