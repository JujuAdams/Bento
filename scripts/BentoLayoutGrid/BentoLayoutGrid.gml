// Feather disable all

/// Sets an element to use a grid ruleset. This is an ortholinear grid that divides the element's
/// content area (the size of the element minus padding) into equally sized cells. The size of each
/// cell is the same. The minimum and maximum size of each cell is determined by the minimum and
/// maximum size of the grid element's children.
/// 
/// If you'd like to change the grid's properties, for example to add a row to an inventory if the
/// player has collected more items, you may call this function again to overwrite existing
/// values.
/// 
/// @param targetColumns
/// @param targetRows
/// @param [minColumns=1]
/// @param [minRows=1]
/// @param [maxColumns]
/// @param [maxRows]
/// @param [element=self]

function BentoLayoutGrid(_targetColumns, _targetRows, _minColumns = 1, _minRows = 1, _maxColumns = infinity, _maxRows = infinity, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutType != BENTO_LAYOUT_GRID)
        {
            //Swapping into grid layout, reset everything
            
            __layoutType = BENTO_LAYOUT_GRID;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __gridTargetColumns = max(1, _targetColumns);
            __gridTargetRows    = max(1, _targetRows);
            __gridMinColumns    = max(1, _minColumns);
            __gridMinRows       = max(1, _minRows);
            __gridMaxColumns    = max(_minColumns, _maxColumns);
            __gridMaxRows       = max(_minRows, _maxRows);
            
            __SolverGetDeflateWidth  = method(self, __BentoSolverGridGetDeflateWidth);
            __SolverResizeWidth      = method(self, __BentoSolverGridResizeWidth);
            __SolverGetDeflateHeight = method(self, __BentoSolverGridGetDeflateHeight);
            __SolverResizeHeight     = method(self, __BentoSolverGridResizeHeight);
            __SolverFinalPositions   = method(self, __BentoSolverGridPositions);
            __funcMeasureHeight      = function() { return 1; }
        }
        else
        {
            //We're already a grid!
            
            //TODO
        }
    }
}