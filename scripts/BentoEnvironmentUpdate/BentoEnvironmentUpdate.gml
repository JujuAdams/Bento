// Feather disable all

/// @param name
/// @param rootX
/// @param rootY
/// @param rootWidth
/// @param roomHeight
/// @param [timeStep=1]

function BentoEnvironmentUpdate(_name, _rootX, _rootY, _rootWidth, _rootHeight, _timeStep = 1)
{
    static _system = __BentoSystem();
    
    var _environment = __BentoEnvironmentFind(_name)
    if (_environment == undefined) return;
    
    var _globalScale = _system.__globalScale;
    _rootX      /= _globalScale;
    _rootY      /= _globalScale;
    _rootWidth  /= _globalScale;
    _rootHeight /= _globalScale;
    
    _environment.__Update(_rootX, _rootY, _rootWidth, _rootHeight, _timeStep);
}