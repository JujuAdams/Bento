// Feather disable all

function __GuiIsInstance(_value)
{
    return (instance_exists(_value) && (not is_struct(_value)));
}