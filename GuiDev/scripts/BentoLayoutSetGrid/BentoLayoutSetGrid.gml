// Feather disable all

/// 
/// 
/// @param columns
/// @param rows
/// @param [element=self]

function BentoLayoutSetGrid(_columns, _rows, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_GRID)
        {
            //Swapping into grid layout, reset everything
            
            __layoutType = BENTO_LAYOUT_GRID;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __gridColumns = max(1, _columns);
            __gridRows    = max(1, _rows);
            
            __SolverGetShrinkWidth  = method(self, __BentoSolverRectGetShrinkWidth);
            __SolverResizeWidth     = method(self, __BentoSolverGridResizeWidth);
            __SolverGetShrinkHeight = method(self, __BentoSolverRectGetShrinkHeight);
            __SolverResizeHeight    = method(self, __BentoSolverGridResizeHeight);
            __SolverPositions       = method(self, __BentoSolverGridPositions);
            __funcMeasureHeight     = function() { return 1; }
        }
        else
        {
            //We're already a grid!
            BentoLayoutSetGridSize(_columns, _rows, _element);
        }
    }
}