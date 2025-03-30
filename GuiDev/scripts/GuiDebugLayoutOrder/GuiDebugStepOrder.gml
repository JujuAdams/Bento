// Feather disable all

/// @param [parent=root]
/// @param [ascii=false]  Whether to use ASCII compatibility mode

function GuiDebugStepOrder(_parent = GUI_ROOT, _ascii = false)
{
    static _system = __GuiSystem();
    
    var _stepOrder = __GuiEnsureDrawOrder();
    var _i = 0;
    repeat(array_length(_stepOrder))
    {
        var _method = _stepOrder[_i];
        var _self = method_get_self(_method);
        show_debug_message(string(real(_self)));
        
        ++_i;
    }
}