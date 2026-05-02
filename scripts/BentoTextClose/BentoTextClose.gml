// Feather disable all

/// Closes text input.

function BentoTextClose()
{
    static _system = __BentoSystem();
    
    with(_system.__textHandlerEnvironment)
    {
        if (__textHandler != undefined)
        {
            __textHandler.__Terminate(BENTO_TEXT_INACTIVE);
            BentoInputConsume(__layerCurrent);
        }
    }
    
    _system.__textHandlerEnvironment = undefined;
}