// Feather disable all

/// @param [blockGamepadWhenOpen=false]
/// @param [hostInstance=id]

function GuiTabSetupHost(_blockGamepadWhenOpen = false, _hostInstance = id)
{
    __tabsEnabled = true;
    __tabsButton  = noone;
    __tabsChild   = noone;
    
    __tabsBlockGamepadWhenOpen = _blockGamepadWhenOpen;
}