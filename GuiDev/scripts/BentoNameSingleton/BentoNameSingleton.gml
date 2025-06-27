// Feather disable all

/// Destroys any old instances that use the name and then names the target instance.
/// 
/// @param name
/// @param [element=self]

function BentoNameSingleton(_name, _element = self)
{
    BentoNameDestroy(_name);
    BentoNameSet(_name, _element);
}