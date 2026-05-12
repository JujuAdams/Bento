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

function BentoCarryItemPick(_element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__carryItemChannel != undefined)
        {
            __layer.__carryNextItemElement = _element;
            __carryItemContinuous = false;
        }
        else
        {
            if (BENTO_SAFE && BENTO_RUNNING_FROM_IDE)
            {
                __BentoError("Cannot pick drag & drop item, its channel is `undefined`\nPlease call `BentoCarrySetItemChannel()`");
            }
        }
    }
}