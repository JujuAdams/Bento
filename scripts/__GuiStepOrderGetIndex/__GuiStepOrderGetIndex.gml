// Feather disable all

/// @param instance

function __GuiStepOrderGetIndex(_instance)
{
    static _stepOrder = __GuiSystem().__stepOrder;
    
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        if (_instance == method_get_self(_stepOrder[_i]))
        {
            return _i;
        }
        
        ++_i;
    }
    
    return undefined;
}