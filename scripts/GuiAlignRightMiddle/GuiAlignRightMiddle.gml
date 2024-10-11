// Feather disable all

/// Sets the absolute position of a GUI instance. If that instance has any children (inside or
/// outside) then the children will follow the parent.
/// 
/// @param instance
/// @param x
/// @param y
/// @param [relative=false]

function GuiAlignRightMiddle(_instance, _x, _y, _relative = false)
{
    if (not instance_exists(_instance)) return;
    
    _x += _instance.width/2;
    
    GuiSetPosition(_instance, _x, _y, _relative);
}