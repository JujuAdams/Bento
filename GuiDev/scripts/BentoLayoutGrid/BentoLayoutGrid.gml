// Feather disable all

/// Sets an element to use a grid ruleset. This is an ortholinear grid that divides the element's
/// content area (the size of the element minus padding) into equally sized cells.
/// 
/// If you'd like to change the grid's properties, for example to add a row to an inventory if the
/// player has collected more items, you may call this functiuon again to overwrite values.
/// 
/// @param columns
/// @param rows
/// @param [element=self]

function BentoLayoutGrid(_columns, _rows, _element = self)
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
            
            if ((_columns != undefined) && (__gridColumns != _columns))
            {
                __gridColumns = max(1, _columns);
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
            
            if ((_rows != undefined) && (__gridRows != _rows))
            {
                __gridRows = max(1, _rows);
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}