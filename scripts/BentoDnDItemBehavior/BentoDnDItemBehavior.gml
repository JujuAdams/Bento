// Feather disable all

/// N.B. To avoid problems with order of execution, the drag & drop system is updated at the start
///      of an update loop. That means the effects of this function will not be applied until the
///      Step after this function is called.
/// 
/// @param [element=self]

function BentoDnDItemBehavior(_element = self)
{
    var _layer = BentoGetLayer(_element);
    
    if (BentoUsingPointer(_layer))
    {
        if (BentoPrimaryGetHold(_element) && BentoPrimaryGetDragged(_layer))
        {
            BentoDnDItemPickContinuous(_element);
        }
    }
    else if (BentoUsingDirectional(_layer))
    {
        if (not BentoDnDIsItem(_element))
        {
            if (BentoPrimaryGetClick(_element))
            {
                BentoDnDItemPick(_element);
            }
        }
        else
        {
            if (BentoPrimaryGetPress(_element) || BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
            {
                BentoDnDItemDrop(_element);
            }
        }
    }
    
    return BentoDnDGetItemDropped()? BentoDnDGetTarget(_element) : BENTO_NO_ELEMENT;
}