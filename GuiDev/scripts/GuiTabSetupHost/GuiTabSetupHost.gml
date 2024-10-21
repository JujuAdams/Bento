// Feather disable all

/// Sets up an instance as a tab host. If `blockGamepadWhenOpen` is set to `true` then tab buttons
/// will not be selectable with a gamepad whilst a tab is open.
/// 
/// @param [blockGamepadWhenOpen=false]
/// @param [hostInstance=id]

function GuiTabSetupHost(_blockGamepadWhenOpen = false, _hostInstance = id)
{
    __tabsEnabled = true;
    __tabsButton  = noone;
    __tabsChild   = noone;
    
    __tabsBlockGamepadWhenOpen = _blockGamepadWhenOpen;
}