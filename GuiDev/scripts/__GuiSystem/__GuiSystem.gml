// Feather disable all

/// Initializes a global struct that contains library state.

//Many GM functions don't support using `infinity`
#macro __GUI_VERY_LARGE  999999

#macro __GUI_RETURN_NORMAL          0
#macro __GUI_RETURN_MODAL           1
#macro __GUI_RETURN_BLOCK_SIBLINGS  2

__GuiSystem();
function __GuiSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __frame = 0;
        
        show_debug_message($"Gui: Version {GUI_VERSION}, {GUI_DATE}");
        
        __scissorStack = [];
        __tempParent = noone;
        
        ////////
        // Global input state
        ////////
        
        __globalMouseX    = 0;
        __globalMouseY    = 0;
        __globalMouseHold = false;
        
        __globalDirectionalDX   = 0;
        __globalDirectionalDY   = 0;
        __globalDirectionalHold = false;
        
        __globalHotkeyInputMap = ds_map_create();
        __globalHotkeyArray    = [];
        
        __globalNavDirPreDelay     = 20;
        __globalNavDirDelay        = 9;
        __globalNavDirDelayCount   = 4;
        __globalNavDirDelayShorter = 5;
        
        ////////
        // Environments
        ////////
        
        __environmentShared  = new __GuiClassEnvironment();
        __environmentArray   = [__environmentShared];
        __environmentCurrent = __environmentShared;
    }
    
    if (GUI_RUNNING_FROM_IDE)
    {
        global.GuiElementMap = ds_map_create();
        global.GuiSystem = _system;
    }
    
    return _system;
}