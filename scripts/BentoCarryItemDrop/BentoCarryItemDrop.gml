// Feather disable all

/// if (BentoUsingNavigation() && BentoHotkeyGetPress("pick up"))
/// {
///     if (BentoCarryIsItem())
///     {
///         BentoCarryItemPick();
///     }
///     else
///     {
///         BentoCarryItemDrop();
///     }
/// }
/// 
/// N.B. To avoid problems with order of execution, the drag & drop system is updated at the start
///      of an update loop. That means the effects of this function will not be applied until the
///      Step after this function is called.
/// 
/// @param [element=self]

function BentoCarryItemDrop(_element = self)
{
    with(__BentoGetVars(_element))
    {
        __carryItemContinuous = true;
        
        if (__layer.__carryNextItemElement == _element)
        {
            __layer.__carryNextItemElement = BENTO_NO_ELEMENT;
        }
    }
}