// Feather disable all

/// @param [columns]
/// @param [rows]
/// @param [instance=id]

function GuiLayoutSetGridSize(_columns, _rows, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (not variable_struct_exists(self, "__gridColumns"))
        {
            __GuiError("Can only apply grid size to objects that inherit from `oGuiLibGrid`");
        }
        
        if (__gridColumns != _columns)
        {
            __gridColumns = _columns;
            __environment.__layoutDirty = true;
        }
        
        if (__gridRows != _rows)
        {
            __gridRows = _rows;
            __environment.__layoutDirty = true;
        }
    }
}