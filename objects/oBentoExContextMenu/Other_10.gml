/// @desc Step

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
{
    BentoInputConsume();
    BentoDestroy();
}