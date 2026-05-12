// Feather disable all

/// N.B. To avoid problems with order of execution, the drag & drop system is updated at the start
///      of an update loop. That means the effects of this function will not be applied until the
///      Step after this function is called.
/// 
/// @param [element=self]

function BentoCarryItemBehavior(_element = self)
{
    var _layer = BentoGetLayer(_element);
    
    if (BentoUsingPointer(_layer))
    {
        if (BentoPrimaryGetHold(_element) && BentoPrimaryGetDragged(_layer))
        {
            BentoCarryItemPickContinuous(_element);
        }
    }
    else if (BentoUsingNavigation(_layer))
    {
        if (not BentoCarryIsItem(_element))
        {
            if (BentoPrimaryGetClick(_element))
            {
                BentoCarryItemPick(_element);
            }
        }
        else
        {
            if (BentoPrimaryGetPress(_element) || BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
            {
                BentoCarryItemDrop(_element);
            }
        }
    }
    
    return BentoCarryGetItemDropped()? BentoCarryGetTarget(_element) : BENTO_NO_ELEMENT;
}