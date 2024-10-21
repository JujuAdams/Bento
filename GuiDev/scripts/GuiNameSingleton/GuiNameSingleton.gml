// Feather disable all

/// Destroys any old instances that use the name and then names the target instance.
/// 
/// @param name
/// @param [instance=id]

function GuiNameSingleton(_name, _instance = id)
{
    GuiNameDestroy(_name);
    GuiNameSet(_name, _instance);
}