// Feather disable all

/// @param target
/// @param [container=self]

function GuiSetContainer(_target, _container = self)
{
    if ((_target != undefined) && (not GuiExists(_target))) return;
    if (not GuiExists(_container)) return;
    
    _container.GUI_VARS.__containerTarget = _target;
    
    if (_target != undefined)
    {
        _target.GUI_VARS.__containerHost = _container;
    }
}