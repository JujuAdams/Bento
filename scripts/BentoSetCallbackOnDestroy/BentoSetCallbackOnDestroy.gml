// Feather disable all

/// @param function
/// @param [parametersArray=[]]
/// @param [element=self]
/// @param [forceScope=false]

function BentoSetCallbackOnDestroy(_function, _parametersArray = undefined, _element = self, _forceScope = false)
{
    with(__BentoGetVars(_element))
    {
        __callbackOnDestroy = _forceScope? method(_element, _function) : _function;
        __callbackOnDestroyParams = _parametersArray;
    }
}