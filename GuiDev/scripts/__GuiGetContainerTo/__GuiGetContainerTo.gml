// Feather disable all

/// @param element

function __GuiGetContainerTarget(_element)
{
    var _container = _element.GUI_VARS.__containerTarget;
    if (_container == undefined) return _element;
    return GuiExists(_container)? _container : undefined;
}