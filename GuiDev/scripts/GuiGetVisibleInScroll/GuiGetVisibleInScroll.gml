// Feather disable all

/// @param [partial=false]
/// @param [element=self]

function GuiGetVisibleInScroll(_partial = false, _element = self)
{
    if (not __GuiExists(_element)) return false;
    
    var _result = __GuiGetScrollDelta(_element);
    if (not __GuiExists(_result.__parent)) return true;
    
    if (_partial || _result.__tooBig)
    {
        //If the UI element is too big then settle for partially visible
        return ((_result.__dX < _element.GUI_VARS.__solvedWidth ) && (_result.__dX >= 0)
             && (_result.__dY < _element.GUI_VARS.__solvedHeight) && (_result.__dY >= 0));
    }
    else
    {
        return ((_result.__dX == 0) && (_result.__dY == 0));
    }
}