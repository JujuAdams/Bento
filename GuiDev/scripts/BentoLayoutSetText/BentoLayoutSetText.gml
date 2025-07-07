// Feather disable all

/// @param measureWidthFunc
/// @param measureHeightFunc
/// @param [element=self]

function BentoLayoutSetText(_funcWidth, _funcHeight, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_TEXT)
        {
            //Swapping into text layout, reset everything
            
            __layoutType = BENTO_LAYOUT_TEXT;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            
            __SolverGetShrinkWidth  = method(self, __BentoSolverTextGetShrinkWidth);
            __SolverResizeWidth     = function(){};
            __SolverGetShrinkHeight = method(self, __BentoSolverTextGetShrinkHeight);
            __SolverResizeHeight    = function(){};
            __SolverPositions       = method(self, __BentoSolverRectPositions);
            __funcMeasureWidth      = method(__attachedElement, _funcWidth);
            __funcMeasureHeight     = method(__attachedElement, _funcHeight);
        }
        else
        {
            //We're already text, check to see if any parameters have changed
            
            if ((method_get_index(_funcWidth ) != method_get_index(__funcMeasureWidth ))
            ||  (method_get_index(_funcHeight) != method_get_index(__funcMeasureHeight)))
            {
                __funcMeasureWidth  = method(__attachedElement, _funcWidth);
                __funcMeasureHeight = method(__attachedElement, _funcHeight);
                
                //Parameters changed, update the layout!
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}