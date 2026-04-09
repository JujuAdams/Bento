// Feather disable all

/// N.B. To avoid problems with order of execution, the drag & drop system is updated at the start
///      of an update loop. That means the effects of this function will not be applied until the
///      Step after this function is called.
/// 
/// @param [element=self]

function BentoDnDItemBehavior(_element = self)
{
    var _layer = BentoGetLayer(_element);
    
    if (BentoUsingPointer(_layer) && BentoPrimaryGetHold(_element) && BentoPrimaryGetDragged(_layer))
    {
        BentoDnDItemPickContinuous(_element);
    }
    else if (BentoUsingDirectional(_layer) && BentoPrimaryGetClick(_element))
    {
        if (BentoDnDIsItem(_element))
        {
            BentoDnDItemPick(_element);
        }
        else
        {
            BentoDnDItemDrop(_element);
        }
    }
}