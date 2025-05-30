// Feather disable all

/// @param element

function __GuiGetContainerHost(_element)
{
    var _container = _element.GUI_VARS.__containerHost;
    if (_container == undefined) return _element;
    return GuiExists(_container)? _container : undefined;
}