// Feather disable all

/// @param listAxis
/// @param hAlignChildren
/// @param vAlignChidlren
/// @param [element=self]

function GuiLayoutSetList(_listAxis, _hAlignChildren, _vAlignChildren, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_LIST)
        {
            //Swapping into list layout, reset everything
            
            __layoutType = GUI_LAYOUT_LIST;
            __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            
            __layoutGutterX = 0;
            __layoutGutterY = 0;
            
            __listAxis = _listAxis;
            __layoutHAlignChildren = _hAlignChildren;
            __layoutVAlignChildren = _vAlignChildren;
            
            __SolverGetShrinkWidth  = method(self, __GuiSolverListGetShrinkWidth);
            __SolverResizeWidth  = method(self, __GuiSolverListResizeWidth);
            __SolverGetShrinkHeight = method(self, __GuiSolverListGetShrinkHeight);
            __SolverResizeHeight = method(self, __GuiSolverListResizeHeight);
            __SolverPositions    = method(self, __GuiSolverListPositions);
            __funcMeasureWidth   = function() { return 1; }
            __funcMeasureHeight  = function() { return 1; }
        }
        else
        {
            //We're already a list, check to see if any parameters have changed
            
            if ((__listAxis != _listAxis)
            ||  (__layoutHAlignChildren != _hAlignChildren)
            ||  (__layoutVAlignChildren != _vAlignChildren))
            {
                __listAxis = _listAxis;
                __layoutHAlignChildren = _hAlignChildren;
                __layoutVAlignChildren = _vAlignChildren;
                
                //Parameters changed, update the layout!
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
    }
}