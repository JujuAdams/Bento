// Feather disable all

/// @param name
/// @param [environment=current]

function GuiLayerCreate(_name, _environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    if (GuiLayerFind(_name, _environment) != undefined)
    {
        __GuiError($"Layer called \"{_name}\" already exist (environment \"{_environment.__name}\")");
    }
    
    return new __GuiClassLayer(_environment, _name);
}