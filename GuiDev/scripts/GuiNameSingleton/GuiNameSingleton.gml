// Feather disable all

/// Destroys any old instances that use the name and then names the target instance.
/// 
/// @param name
/// @param [instance=self]

function GuiNameSingleton(_name, _instance = self)
{
    GuiNameDestroy(_name);
    GuiNameSet(_name, _instance);
}