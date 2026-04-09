// Feather disable all

/// if (BentoUsingPointer() && BentoPrimaryGetHold() && BentoPrimaryGetDragged())
/// {
///     BentoDnDItemPickContinuous();
/// }
/// 
/// You may also want to consider using `BentoPrimaryGetLongHold()` if you'd like to pick up an
/// item only after a long press. For accessibility reason, you may also want to use the state
/// setting variants: please see `BentoDnDItemPick()` and `BentoDnDItemDrop()`.
/// 
/// N.B. To avoid problems with order of execution, the drag & drop system is updated at the start
///      of an update loop. That means the effects of this function will not be applied until the
///      Step after this function is called.
/// 
/// @param [element=self]

function BentoDnDItemPickContinuous(_element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__dndItemChannel != undefined)
        {
            __layer.__dndNextItemElement = _element;
            __dndItemContinuous = true;
        }
        else
        {
            if (BENTO_SAFE && BENTO_RUNNING_FROM_IDE)
            {
                __BentoError("Cannot pick drag & drop item, its channel is `undefined`\nPlease call `BentoDnDSetItemChannel()`");
            }
        }
    }
}