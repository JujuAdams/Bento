// Feather disable all

function __BentoIsInstance(_value)
{
    return (instance_exists(_value) && (not is_struct(_value)));
}