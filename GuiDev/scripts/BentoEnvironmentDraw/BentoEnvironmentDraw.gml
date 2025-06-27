// Feather disable all

/// Draws an environment with the given name. If no environment exists then this function will do
/// nothing.
/// 
/// N.B. If you're calling `BentoSystemDraw()` then you don't need to call this function.
/// 
/// @param name

function BentoEnvironmentDraw(_name)
{
    var _environment = __BentoEnvironmentFind(_name)
    if (_environment == undefined) return;
    
    _environment.__Draw();
}