// Feather disable all

/// @param name

function GuiEnvironmentCreate(_name)
{
    static _system = __GuiSystem();
    with(_system)
    {
        if (GuiEnvironmentExists(_name))
        {
            __GuiError($"Environment with name {_name} already exists");
        }
        
        var _environment = new __GuiClassEnvironment(_name);
        array_push(__environmentArray, _environment);
        
        return _environment;
    }
    
    return undefined;
}