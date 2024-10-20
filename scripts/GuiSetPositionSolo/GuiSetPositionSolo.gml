// Feather disable all

/// Sets the absolute position of a GUI instance. This function, unlike `GuiSetPosition()`, will
/// not move the target instance's children.
/// 
/// @param x
/// @param y
/// @param [instance=id]
/// @param [relative=false]

function GuiSetPositionSolo(_x, _y, _instance = id, _relative = false)
{
    if (not instance_exists(_instance)) return;
    
    if (_relative)
    {
        var _parent = _instance.__parent;
        if (instance_exists(_parent))
        {
            _x += _parent.x;
            _y += _parent.y;
        }
    }
    
    GuiMoveSolo(_x - _instance.x, _y - _instance.y, _instance);
}