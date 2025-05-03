// Feather disable all

/// Destroys any old instances that use the name and then names the target instance.
/// 
/// @param name
/// @param [element=self]

function GuiNameSingleton(_name, _element = self)
{
    GuiNameDestroy(_name);
    GuiNameSet(_name, _element);
}