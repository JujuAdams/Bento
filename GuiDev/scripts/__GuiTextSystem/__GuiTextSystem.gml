// Feather disable all

#macro __GUI_TEXT_IOS_MAX  1000

#macro __GUI_BACKSPACE_REPEAT_DELAY     500
#macro __GUI_BACKSPACE_REPEAT_INTERVAL   33

function __GuiTextSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    
    with(_system)
    {
        __handler = undefined;
        __text    = "";
        __state   = GUI_TEXT_INACTIVE;
        
        __useSteamKeyboard = false;
        
        if (GUI_STEAMWORKS_SUPPORT)
        {
            try
            {
                //Using Steamworks extension
                var _usingSteamworks = steam_init();
                var _onSteamDeck     = steam_utils_is_steam_running_on_steam_deck();
                
                if (_usingSteamworks && _onSteamDeck)
                {
                    steam_utils_enable_callbacks();
                    __useSteamKeyboard = true;
                }
            }
            catch(_error)
            {
                show_debug_message("Steamworks extension unavailable");
            }
        }
    }
    
    return _system;
}