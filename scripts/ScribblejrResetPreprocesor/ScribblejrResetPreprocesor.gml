// Feather disable all

/// Resets the current preprocessor to the default, as set by `ScribblejrSetPreprocesorDefault()`.

function ScribblejrResetPreprocesor()
{
    static _system = __ScribblejrSystem();
    
    with(_system)
    {
        if (not __preprocessorUsingDefault)
        {
            __preprocessorUsingDefault = true;
            
            __preprocessorMethod = __preprocessorDefault;
            __preprocessorName   = __preprocessorDefaultName;
            
            __preprocessorOnce = false;
        }
    }
}