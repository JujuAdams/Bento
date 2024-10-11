// Feather disable all

/// Sets the absolute position of a GUI instance. If that instance has any children (inside or
/// outside) then the children will follow the parent.
/// 
/// @param instance
/// @param x
/// @param y
/// @param [relative=false]

function GuiSetPosition(_instance, _x, _y, _relative = false)
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
    
    GuiMove(_instance, _x - _instance.x, _y - _instance.y);
}