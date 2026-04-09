// Feather disable all

/// if (BentoUsingDirectional() && BentoHotkeyGetPress("pick up"))
/// {
///     if (BentoDnDIsItem())
///     {
///         BentoDnDItemPick();
///     }
///     else
///     {
///         BentoDnDItemDrop();
///     }
/// }
/// 
/// N.B. To avoid problems with order of execution, the drag & drop system is updated at the start
///      of an update loop. That means the effects of this function will not be applied until the
///      Step after this function is called.
/// 
/// @param [element=self]

function BentoDnDItemDrop(_element = self)
{
    with(__BentoGetVars(_element))
    {
        __dndItemContinuous = true;
        
        if (__layer.__dndNextItemElement == _element)
        {
            __layer.__dndNextItemElement = BENTO_NO_ELEMENT;
        }
    }
}