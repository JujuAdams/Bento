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

//Figure out if our tab is open by checking the `ident` variable on the tab container
var _target = BentoNameFind(targetName);
tabOpen = (BentoExists(_target) && struct_exists(_target, "ident") && (ident == _target.ident));

//Then allow us to use hotkeys to rotate between tab buttons. We presume that our sibling elemnets
//are also tab buttons so we can check the tab buttons around us to see if we should open our own
//tab when a hotkey is pressed
var _childIndex = BentoGetChildIndex();
if (_childIndex != undefined)
{
    if (BentoHotkeyGetPress("tab left"))
    {
        var _nextSibling = BentoGetChild(_childIndex+1, BentoGetParent());
        if (BentoExists(_nextSibling) && struct_exists(_nextSibling, "tabOpen") && _nextSibling.tabOpen)
        {
            audio_play_sound(sndBentoExBeep, 0, false);
            func();
        }
    }
    
    if (BentoHotkeyGetPress("tab right"))
    {
        var _prevSibling = BentoGetChild(_childIndex-1, BentoGetParent());
        if (BentoExists(_prevSibling) && struct_exists(_prevSibling, "tabOpen") && _prevSibling.tabOpen)
        {
            audio_play_sound(sndBentoExBeep, 0, false);
            func();
        }
    }
}