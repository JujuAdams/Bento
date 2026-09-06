// Feather disable all

/// Creates a dynamically resizing table with a fixed number of columns. Elements will be arranged
/// in the table from the top-left cell to the bottom-right cell with each added element occupying
/// a single cell.
/// 
/// The `rowVAlign` parameter controls how children are positioned if content doesn't fill up the
/// full height of a row. This value should typically be a number from `0` to `1`.
/// 
/// N.B. Do not use `fa_*` constants with this function. Provide a number for the alignments.
/// 
/// @param columns
/// @param rowVAlign
/// @param rowMaxHeight
/// @param [element=self]

function BentoLayoutTable(_columns, _rowVAlign, _rowHaxHeight, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutType != BENTO_LAYOUT_TABLE)
        {
            //Swapping into table layout, reset everything
            
            __layoutType = BENTO_LAYOUT_TABLE;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __tableColumns   = _columns;
            __tableVAlign    = _rowVAlign;    //Shared across all rows
            __tableMaxHeight = _rowHaxHeight; //Shared across all rows
            
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
            
            if (_columns != undefined)
            {
                if (__tableVAlign != _rowVAlign)
                {
                    __tableVAlign = _rowVAlign;
                    __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
                }
            }
            
            if (_rowHaxHeight != undefined)
            {
                if (__tableMaxHeight != _rowHaxHeight)
                {
                    __tableMaxHeight = _rowHaxHeight;
                    __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
                }
            }
        }
    }
}