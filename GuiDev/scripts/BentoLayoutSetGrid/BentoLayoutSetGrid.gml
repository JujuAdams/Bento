// Feather disable all

/// @param columns
/// @param rows
/// @param [element=self]

function BentoLayoutSetGrid(_columns, _rows, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_GRID)
        {
            //Swapping into grid layout, reset everything
            
            __layoutType = GUI_LAYOUT_GRID;
            __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            
            __layoutGutterX = 0;
            __layoutGutterY = 0;
            
            __gridColumns = max(1, _columns);
            __gridRows    = max(1, _rows);
            
            __SolverGetShrinkWidth  = method(self, __BentoSolverRectGetShrinkWidth);
            __SolverResizeWidth  = method(self, __BentoSolverGridResizeWidth);
            __SolverGetShrinkHeight = method(self, __BentoSolverRectGetShrinkHeight);
            __SolverResizeHeight = method(self, __BentoSolverGridResizeHeight);
            __SolverPositions    = method(self, __BentoSolverGridPositions);
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
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
    }
}