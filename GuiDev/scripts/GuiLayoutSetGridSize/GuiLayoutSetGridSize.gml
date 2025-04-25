// Feather disable all

/// @param [columns]
/// @param [rows]
/// @param [instance=id]

function GuiLayoutSetGridSize(_columns, _rows, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    if (not variable_instance_exists(_instance, "__gridColumns"))
    {
        __GuiError("Can only apply grid size to objects that inherit from `oGuiLibGrid`");
    }
    
    with(_instance.__gui)
    {
        if (__gridColumns != _columns)
        {
            __gridColumns = _columns;
            _system.__layoutDirty = true;
        }
        
        if (__gridRows != _rows)
        {
            __gridRows = _rows;
            _system.__layoutDirty = true;
        }
    }
}