// Feather disable all

/// @param [element=self]

function GuiClipGetFullyVisible(_element = self)
{
    if (not GuiExists(_element)) return false;
    
    var _scissorVisibility = _element.GUI_VARS.__scissorVisibility;
    if (_scissorVisibility == GUI_VISIBLE_NONE)
    {
        return false;
    }
    else if (_scissorVisibility == GUI_VISIBLE_FULL)
    {
        return true;
    }
    else // (_scissorVisibility == GUI_VISIBLE_PARTIAL)
    {
        //Test for oversize
        
        //FIXME - This is pretty gross code. Need to find a better solution
        var _parent = __GuiScrollFindParent(_element.GUI_VARS.__parent);
        if (GuiExists(_parent))
        {
            with(_parent.GUI_VARS)
            {
                if (__scrollHori)
                {
                    var _instL = _element.guiLeft  - GUI_SCROLL_TO_PADDING;
                    var _instR = _element.guiRight + GUI_SCROLL_TO_PADDING;
                    
                    if (__scissorEnabled)
                    {
                        var _parL = _parent.guiLeft  + __scissorPadLeft  + __scissorScrollbarLeft;
                        var _parR = _parent.guiRight - __scissorPadRight + __scissorScrollbarRight;
                    }
                    else
                    {
                        var _parL = _parent.guiLeft;
                        var _parR = _parent.guiRight;
                    }
                    
                    if (_instR - _instL > _parR - _parL) return true;
                }
                
                if (__scrollVert)
                {
                    var _instT = _element.guiTop    - GUI_SCROLL_TO_PADDING;
                    var _instB = _element.guiBottom + GUI_SCROLL_TO_PADDING;
                    
                    if (__scissorEnabled)
                    {
                        var _parT = _parent.guiTop    + __scissorPadTop    + __scissorScrollbarTop;
                        var _parB = _parent.guiBottom - __scissorPadBottom - __scissorScrollbarBottom;
                    }
                    else
                    {
                        var _parT = _parent.guiTop;
                        var _parB = _parent.guiBottom;
                    }
                    
                    if (_instB - _instT > _parB - _parT) return true;
                }
            }
        }
        
        return false;
    }
}