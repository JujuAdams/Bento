// Feather disable all

/// @desc Step

//If Bento thinks this button has been clicked then trigger the callback function
if (BentoPrimaryGetClick())
{
    audio_play_sound(sndBentoExBeep, 0, false);
    
    if (is_callable(func))
    {
        func();
    }
}

if (BentoCursorGetEnterByNavigation() && BentoUsingDirectional())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}

//if (BentoPrimaryGetHold())
//{
//    BentoDnDItemPickContinuous();
//}

BentoDnDItemBehavior();

if (BentoDnDIsItem())
{
    show_debug_message("We are being dragged");
}

if (BentoDnDGetItemDropped())
{
    show_debug_message("We were dropped");
    
    with(BentoDnDGetDropTarget())
    {
        show_debug_message($"Target ID = {id}");
    }
}