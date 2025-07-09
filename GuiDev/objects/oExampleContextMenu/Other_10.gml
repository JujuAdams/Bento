/// @desc Step

if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL))
{
    BentoInputConsume();
    BentoDestroy();
}