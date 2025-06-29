// Feather disable all

/// Initializes a global struct that contains library state.

//Many GM functions don't support using `infinity`
#macro __BENTO_VERY_LARGE  999999

#macro __BENTO_OFF    0b00  //0
#macro __BENTO_START  0b10  //2
#macro __BENTO_ON     0b11  //3
#macro __BENTO_END    0b01  //1

#macro __BENTO_DIRTY_LAYOUT     0b0001
#macro __BENTO_DIRTY_STEP       0b0010
#macro __BENTO_DIRTY_HOVERABLE  0b0100
#macro __BENTO_DIRTY_DRAW       0b1000
#macro __BENTO_DIRTY_ALL        0b1111

#macro __BENTO_TEXT_IOS_MAX  1000

__BentoSystem();
function __BentoSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __frame = 0;
        
        show_debug_message($"Bento: Version {BENTO_VERSION}, {BENTO_DATE}");
        
        __scissorStack = [];
        
        __creatingObject = false;
        __tempParent     = BENTO_NO_ELEMENT;
        
        __globalDirPreDelay     = 20;
        __globalDirDelay        = 9;
        __globalDirDelayCount   = 4;
        __globalDirDelayShorter = 5;
        
        __environmentArray = [];
        var _environment = BentoEnvironmentCreate("default");
        
        __environmentStack   = [];
        __environmentCurrent = _environment;
        
        __layerStack   = [];
        __layerCurrent = __environmentCurrent.__layerCurrent;
        
        __textUseSteamKeyboard   = false;
        __textHandlerEnvironment = undefined;
            
        if (BENTO_STEAMWORKS_SUPPORT)
        {
            try
            {
                //Using Steamworks extension
                var _usingSteamworks = steam_init();
                var _onSteamDeck     = steam_utils_is_steam_running_on_steam_deck();
                
                if (_usingSteamworks && _onSteamDeck)
                {
                    steam_utils_enable_callbacks();
                    __textUseSteamKeyboard = true;
                }
            }
            catch(_error)
            {
                show_debug_message("Steamworks extension unavailable");
            }
        }
    }
    
    if (BENTO_RUNNING_FROM_IDE)
    {
        global.BentoElementMap = ds_map_create();
        global.BentoSystem = _system;
    }
    
    return _system;
}