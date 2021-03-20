/// @param name

function BentoConstantExists(_name)
{
    return variable_struct_exists(global.__bentoConstants, _name);
}