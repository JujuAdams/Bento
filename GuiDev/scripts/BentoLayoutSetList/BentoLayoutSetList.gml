// Feather disable all

/// 
/// 
/// @param listAxis
/// @param hAlignChildren
/// @param vAlignChidlren
/// @param [element=self]

function BentoLayoutSetList(_listAxis, _hAlignChildren, _vAlignChildren, _element = self)
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
            
            __SolverGetShrinkWidth  = method(self, __BentoSolverListGetShrinkWidth);
            __SolverResizeWidth     = method(self, __BentoSolverListResizeWidth);
            __SolverGetShrinkHeight = method(self, __BentoSolverListGetShrinkHeight);
            __SolverResizeHeight    = method(self, __BentoSolverListResizeHeight);
            __SolverPositions       = method(self, __BentoSolverListPositions);
            __funcMeasureHeight     = function() { return 1; }
        }
        else
        {
            //We're already a list!
            BentoLayoutSetListAxis(_listAxis, _element);
            BentoLayoutSetListAlign(_hAlignChildren, _vAlignChildren, _element);
        }
    }
}