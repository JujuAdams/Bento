// Feather disable all

/// The most basic layout ruleset. This ruleset will do no automatic positioning of child elements.
/// This makes it helpful as the root container or as a container for unstructured content.
/// 
/// Elements using this ruleset will not change their size based on `BENTO_RESIZE_DEFLATE`
/// resizing. They will, however, change their size based on `BENTO_RESIZE_INFLATE`.
/// 
/// @param [element=self]

function BentoLayoutRect(_element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutType != BENTO_LAYOUT_RECT)
        {
            //Swapping into rect layout, reset everything
            
            __layoutType = BENTO_LAYOUT_RECT;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __SolverGetDeflateWidth  = method(self, __BentoSolverRectGetDeflateWidth);
            __SolverResizeWidth      = function() {}
            __SolverGetDeflateHeight = method(self, __BentoSolverRectGetDeflateHeight);
            __SolverResizeHeight     = method(self, __BentoSolverMaintainAspectRatio);
            __SolverFinalPositions   = method(self, __BentoSolverRectPositions);
            __funcMeasureHeight      = function() { return 1; }
        }
    }
}