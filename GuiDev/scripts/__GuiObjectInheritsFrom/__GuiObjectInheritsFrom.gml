// Feather disable all

/// @param descendent
/// @param ancestor

function __GuiObjectInheritsFrom(_descendent, _ancestor)
{
    return ((_descendent == _ancestor) || object_is_ancestor(_descendent, _ancestor));
}