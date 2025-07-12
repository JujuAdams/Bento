// Feather disable all

/// Destroys an environment. This will trigger destroy code for all elements in the environment.
/// 
/// @param environment

function BentoEnvironmentDestroy(_environment)
{
    if (not is_struct(_environment)) return;
    
    _environment.__Destroy();
}