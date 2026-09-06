// Feather disable all

/// Creates a dynamically resizing table with a fixed number of columns. Elements will be arranged
/// in the table from the top-left cell to the bottom-right cell with each added element occupying
/// a single cell.
/// 
/// N.B. Do not use `fa_*` constants with this function. Provide a number for the alignments.
/// 
/// @param columns
/// @param [element=self]

function BentoLayoutTable(_columns, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutType != BENTO_LAYOUT_TABLE)
        {
            //Swapping into list layout, reset everything
            
            __layoutType = BENTO_LAYOUT_TABLE;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __tableColumns = _columns;
            
            __SolverGetDeflateWidth  = method(self, __BentoSolverTableGetDeflateWidth);
            __SolverResizeWidth      = method(self, __BentoSolverTableResizeWidth);
            __SolverGetDeflateHeight = method(self, __BentoSolverTableGetDeflateHeight);
            __SolverResizeHeight     = method(self, __BentoSolverTableResizeHeight);
            __SolverFinalPositions   = method(self, __BentoSolverTablePositions);
            __funcMeasureHeight      = function() { return 1; }
        }
        else
        {
            //We're already a table!
            
            if (_columns != undefined)
            {
                if (__tableColumns != _columns)
                {
                    __tableColumns = _columns;
                    __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
                }
            }
        }
    }
}