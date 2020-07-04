/// @function __bento_mouse_event(event)
/// @param event
function __bento_mouse_event(_event)
{
    __bento_call_method(property.fixed_mouse_event, _event);
    __bento_call_method(variable_struct_get(event, "mouse_" + _event));
}