// Feather disable all

/// Forces the activation of all Bento elements using GameMaker's native activation functions. This
/// is helpful to call after instance deactivation calls to ensure Bento elements remain functional.

function BentoActivateInstances()
{
    instance_activate_object(oBentoAncestor);
}