// Feather disable all

/// @param name

function BentoEnvironmentCreate(_name)
{
    static _system = __BentoSystem();
    with(_system)
    {
        if (BentoEnvironmentExists(_name))
        {
            __BentoError($"Environment with name {_name} already exists");
        }
        
        var _environment = new __BentoClassEnvironment(_name);
        array_push(__environmentArray, _environment);
        
        return _environment;
    }
    
    return undefined;
}