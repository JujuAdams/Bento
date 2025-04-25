// Feather disable all

/// @param [partial=false]
/// @param [instance=id]

function GuiGetVisibleInScroll(_partial = false, _instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    var _result = __GuiGetScrollDelta(_instance);
    if (not instance_exists(_result.__parent)) return true;
    
    if (_partial || _result.__tooBig)
    {
        //If the UI element is too big then settle for partially visible
        return ((_result.__dX < _instance.GUI_STRUCT.__solvedWidth ) && (_result.__dX >= 0)
             && (_result.__dY < _instance.GUI_STRUCT.__solvedHeight) && (_result.__dY >= 0));
    }
    else
    {
        return ((_result.__dX == 0) && (_result.__dY == 0));
    }
}