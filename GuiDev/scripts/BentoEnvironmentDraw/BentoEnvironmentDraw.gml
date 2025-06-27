// Feather disable all

/// @param name

function BentoEnvironmentDraw(_name)
{
    var _environment = BentoEnvironmentFind(_name)
    if (_environment == undefined) return;
    
    _environment.__Draw();
}