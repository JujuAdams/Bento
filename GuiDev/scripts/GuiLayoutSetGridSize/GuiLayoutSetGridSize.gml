// Feather disable all

/// @param [columns]
/// @param [rows]
/// @param [element=self]

function GuiLayoutSetGridSize(_columns, _rows, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (not variable_struct_exists(self, "__gridColumns"))
        {
            __GuiError("Can only apply grid size to objects that inherit from `oGuiLibGrid`");
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