// Feather disable all

/// @param layout
/// @param object
/// @param [struct]

function GuiCreateInLayout(_layout, _object, _struct = undefined)
{
    if (_layout.__inside)
    {
        var _instance = GuiCreateInside(_object, _struct, _layout.__parent);
    }
    else
    {
        var _instance = GuiCreateOutside(_object, _struct, _layout.__parent);
    }
    
    _layout.__Add(_instance);
    
    return _instance;
}