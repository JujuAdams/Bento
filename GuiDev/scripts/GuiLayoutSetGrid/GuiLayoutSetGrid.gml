// Feather disable all

/// @param [element=self]

function GuiLayoutSetGrid(_element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_GRID)
        {
            __layoutType = GUI_LAYOUT_GRID;
            __layer.__layoutDirty = true;
            
            __layoutGutterX = 0;
            __layoutGutterY = 0;
            
            __gridColumns = 1;
            __gridRows    = 1;
            
            __SolverShrinkWidth  = method(self, __GuiSolverRectShrinkWidth);
            __SolverResizeWidth  = method(self, __GuiSolverGridResizeWidth);
            __SolverShrinkHeight = method(self, __GuiSolverRectShrinkHeight);
            __SolverResizeHeight = method(self, __GuiSolverGridResizeHeight);
            __SolverPositions    = method(self, __GuiSolverGridPositions);
            __funcMeasureWidth   = function() { return 1; }
            __funcMeasureHeight  = function() { return 1; }
        }
    }
}