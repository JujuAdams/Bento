// Feather disable all

/// Destroys any elements that uses the given name and then names the target element.
/// 
/// @param name
/// @param [element=self]

function BentoNameSingleton(_name, _element = self)
{
    BentoNameDestroy(_name);
    BentoNameSet(_name, _element);
}