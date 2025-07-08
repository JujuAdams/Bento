// Feather disable all

/// Sets an element to use a list ruleset. Lists can be orientated in either the x or y axis by
/// providing a different constant to the `listAxis` parameter (either `BENTO_AXIS_X` or
/// `BENTO_AXIS_Y`). The `hAlignChildren` and `vAlignChidlren` parameters control how children are
/// positioned if content doesn't fill up the list element itself.
/// 
/// If you'd like to change the list's properties, you may call this functiuon again to overwrite
/// existing values.
/// 
/// @param listAxis
/// @param hAlignChildren
/// @param vAlignChidlren
/// @param [element=self]

function BentoLayoutList(_listAxis, _hAlignChildren, _vAlignChildren, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_LIST)
        {
            //Swapping into list layout, reset everything
            
            __layoutType = BENTO_LAYOUT_LIST;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __listAxis = _listAxis;
            __layoutHAlignChildren = _hAlignChildren;
            __layoutVAlignChildren = _vAlignChildren;
            
            __SolverGetDeflateWidth  = method(self, __BentoSolverListGetDeflateWidth);
            __SolverResizeWidth      = method(self, __BentoSolverListResizeWidth);
            __SolverGetDeflateHeight = method(self, __BentoSolverListGetDeflateHeight);
            __SolverResizeHeight     = method(self, __BentoSolverListResizeHeight);
            __SolverPositions        = method(self, __BentoSolverListPositions);
            __funcMeasureHeight      = function() { return 1; }
        }
        else
        {
            //We're already a list!
            
            if ((_listAxis != undefined) && (__listAxis != _listAxis))
            {
                __listAxis = _listAxis;
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