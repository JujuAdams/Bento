// Feather disable all

/// @param [columns]
/// @param [rows]
/// @param [element=self]

function GuiLayoutSetGridSize(_columns, _rows, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutType != GUI_LAYOUT_GRID)
        {
            __GuiError("Can only apply grid size to elements using a list layout");
        }
        
        if (__gridColumns != _columns)
        {
            __gridColumns = _columns;
            __layer.__layoutDirty = true;
        }
        
        if (__gridRows != _rows)
        {
            __gridRows = _rows;
            __layer.__layoutDirty = true;
        }
    }
}