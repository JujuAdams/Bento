// Feather disable all

/// Finds an instance in the global step order. This function will return `undefined `if the
/// instance is not in the step order.
/// 
/// @param instance

function __GuiStepOrderGetIndex(_instance)
{
    if (not instance_exists(_instance)) return undefined;
    
    var _stepOrder = _instance.GUI_VARS.__environment.__stepOrder;
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