/// @desc Step

if (BentoPrimaryGetClick())
{
    BentoRefSet(reference, value);
    
    if (is_callable(func))
    {
        func(value);
    }
}

if (BentoCursorGetEnterByNavigation() && BentoUsingDirectional())
{
    audio_play_sound(sndBentoExBlip, 0, false);
}