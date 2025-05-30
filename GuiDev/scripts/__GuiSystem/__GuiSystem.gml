// Feather disable all

/// Initializes a global struct that contains library state.

//Many GM functions don't support using `infinity`
#macro __GUI_VERY_LARGE  999999

#macro __GUI_OFF    0b00  //0
#macro __GUI_START  0b10  //2
#macro __GUI_ON     0b11  //3
#macro __GUI_END    0b01  //1

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
        
        __tempParent          = noone;
        __tempIgnoreContainer = false;
        
        __globalDirPreDelay     = 20;
        __globalDirDelay        = 9;
        __globalDirDelayCount   = 4;
        __globalDirDelayShorter = 5;
        
        __environmentArray = [];
        var _environment = GuiEnvironmentCreate("default");
        
        __environmentStack = [];
        __environmentCurrent = _environment;
        
        __layerStack = [];
        __layerCurrent = __environmentCurrent.__layerCurrent;
    }
    
    if (GUI_RUNNING_FROM_IDE)
    {
        global.GuiElementMap = ds_map_create();
        global.GuiSystem = _system;
    }
    
    return _system;
}