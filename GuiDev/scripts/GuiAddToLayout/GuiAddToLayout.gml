// Feather disable all

/// @param layout
/// @param [instance=id]

function GuiAddToLayout(_layout, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    if (_instance.__layout != undefined)
    {
        _instance.__layout.__Remove(_instance);
    }
    
    GuiSetParent(_layout.__parent, _layout.__inside, _instance);
    _layout.__Add(_instance);
}