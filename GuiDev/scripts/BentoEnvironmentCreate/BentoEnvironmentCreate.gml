// Feather disable all

/// Create a new environment. You should specify a unique name that will be usedc to refer to the
/// environment elsewhere. All environments will be updated by `BentoSystemStep()`. All
/// environments will be further be draw by `BentoSystemDraw()`.
/// 
/// N.B. `BentoEnvironmentCreate()` is provided for situations where you'll need to create wholly
///      different user interfaces. A default environment (with the name "default") is
///      automatically created when the library is initialized and you'll probably never need to
///      call this function.
/// 
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