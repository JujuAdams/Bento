// Feather disable all

/// @param columns
/// @param rows
/// @param [element=self]

function GuiLayoutSetGrid(_columns, _rows, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_GRID)
        {
            //Swapping into grid layout, reset everything
            
            __layoutType = GUI_LAYOUT_GRID;
            __layer.__layoutDirty = true;
            
            __layoutGutterX = 0;
            __layoutGutterY = 0;
            
            __gridColumns = max(1, _columns);
            __gridRows    = max(1, _rows);
            
            __SolverShrinkWidth  = method(self, __GuiSolverRectShrinkWidth);
            __SolverResizeWidth  = method(self, __GuiSolverGridResizeWidth);
            __SolverShrinkHeight = method(self, __GuiSolverRectShrinkHeight);
            __SolverResizeHeight = method(self, __GuiSolverGridResizeHeight);
            __SolverPositions    = method(self, __GuiSolverGridPositions);
            __funcMeasureWidth   = function() { return 1; }
            __funcMeasureHeight  = function() { return 1; }
        }
        else
        {
            //We're already a grid, check to see if any parameters have changed
            
            if ((__gridColumns != _columns)
            ||  (__gridRows    != _rows))
            {
                __gridColumns = _columns;
                __gridRows    = _rows;
                
                //Parameters changed, update the layout!
                __layer.__layoutDirty = true;
            }
        }
    }
}