// Feather disable all

/// @desc Step

BentoSetButton(BentoDnDIsValidTarget()? BENTO_BUTTON_ALWAYS : BENTO_BUTTON_NEVER);

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