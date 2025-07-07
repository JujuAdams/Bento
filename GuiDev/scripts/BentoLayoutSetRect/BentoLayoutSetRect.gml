// Feather disable all

/// @param [element=self]

function BentoLayoutSetRect(_element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_RECT)
        {
            //Swapping into rect layout, reset everything
            
            __layoutType = BENTO_LAYOUT_RECT;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __SolverGetShrinkWidth  = method(self, __BentoSolverRectGetShrinkWidth);
            __SolverResizeWidth     = function() {}
            __SolverGetShrinkHeight = method(self, __BentoSolverRectGetShrinkHeight);
            __SolverResizeHeight    = function() {}
            __SolverPositions       = method(self, __BentoSolverRectPositions);
            __funcMeasureWidth      = function() { return 1; }
            __funcMeasureHeight     = function() { return 1; }
        }
    }
}