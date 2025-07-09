// Feather disable all

/// Sets whether an element should have its position and size adjusted by the layout algorithm.
/// Setting an element to bypassed will "freeze" the element's calculated position.
/// 
/// @param state
/// @param [element=self]

function BentoLayoutSetBypass(_state, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__layoutBypass != _state)
        {
            __layoutBypass = _state;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}