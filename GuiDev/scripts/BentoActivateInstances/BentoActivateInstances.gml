// Feather disable all

/// Forces the activation of all Bento instances using GameMaker's native activation functions. This
/// is helpful to call after instance deactivation calls to ensure Bento instances remain functional.

function BentoActivateInstances()
{
    instance_activate_object(oBentoAncestor);
}