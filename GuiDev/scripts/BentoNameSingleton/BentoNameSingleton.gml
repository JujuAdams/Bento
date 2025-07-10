// Feather disable all

/// Destroys any elements that uses the given name and then names the target element.
/// 
/// @param name
/// @param [element=self]
/// @param [environmentOrName=current]

function BentoNameSingleton(_name, _element = self, _environmentOrName = undefined)
{
    BentoNameDestroy(_name, _environmentOrName);
    BentoNameSet(_name, _element);
}