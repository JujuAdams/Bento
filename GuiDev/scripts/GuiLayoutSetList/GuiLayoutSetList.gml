// Feather disable all

/// @param [element=self]

function GuiLayoutSetList(_element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_LIST)
        {
            __layoutType = GUI_LAYOUT_LIST;
            __layer.__layoutDirty = true;
            
            __layoutGutterX = 0;
            __layoutGutterY = 0;
            
            __listAxis = GUI_AXIS_Y;
            __layoutHAlignChildren = fa_left;
            __layoutVAlignChildren = fa_top;
            
            __SolverShrinkWidth  = method(self, __GuiSolverListShrinkWidth);
            __SolverResizeWidth  = method(self, __GuiSolverListResizeWidth);
            __SolverShrinkHeight = method(self, __GuiSolverListShrinkHeight);
            __SolverResizeHeight = method(self, __GuiSolverListResizeHeight);
            __SolverPositions    = method(self, __GuiSolverListPositions);
            __funcMeasureWidth   = function() { return 1; }
            __funcMeasureHeight  = function() { return 1; }
        }
    }
}