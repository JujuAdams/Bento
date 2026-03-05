// Feather disable all

/// Sets an element to use a list ruleset. Lists can be orientated in either the x or y axis by
/// providing a different constant to the `majorAxis` parameter (either `BENTO_AXIS_X` or
/// `BENTO_AXIS_Y`).
/// 
/// The `hAlignChildren` and `vAlignChidlren` parameters control how children are positioned if
/// content doesn't fill up the list element itself. Both values should typically be a number from
/// `0` to `1`.
/// 
/// If you'd like to change the list's properties, you may call this functiuon again to overwrite
/// existing values.
/// 
/// @param majorAxis
/// @param hAlignChildren
/// @param vAlignChidlren
/// @param [element=self]

function BentoLayoutList(_majorAxis, _hAlignChildren, _vAlignChildren, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutType != BENTO_LAYOUT_LIST)
        {
            //Swapping into list layout, reset everything
            
            __layoutType = BENTO_LAYOUT_LIST;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __listAxis = _majorAxis;
            __layoutHAlignChildren = _hAlignChildren;
            __layoutVAlignChildren = _vAlignChildren;
            
            __SolverGetDeflateWidth  = method(self, __BentoSolverListGetDeflateWidth);
            __SolverResizeWidth      = method(self, __BentoSolverListResizeWidth);
            __SolverGetDeflateHeight = method(self, __BentoSolverListGetDeflateHeight);
            __SolverResizeHeight     = method(self, __BentoSolverListResizeHeight);
            __SolverFinalPositions   = method(self, __BentoSolverListPositions);
            __funcMeasureHeight      = function() { return 1; }
        }
        else
        {
            //We're already a list!
            
            if ((_majorAxis != undefined) && (__listAxis != _majorAxis))
            {
                __listAxis = _majorAxis;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
            
            if (_hAlignChildren != undefined)
            {
                if (__layoutHAlignChildren != _hAlignChildren)
                {
                    __layoutHAlignChildren = _hAlignChildren;
                    __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
                }
            }
            
            if (_vAlignChildren != undefined)
            {
                if (__layoutVAlignChildren != _vAlignChildren)
                {
                    __layoutVAlignChildren = _vAlignChildren;
                    __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
                }
            }
        }
    }
}