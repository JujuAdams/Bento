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
        
        __rootInstance = undefined;
        __guiIndex = 0;
        
        __stepRootStack = [];
        __stepOrder     = [];
        __stepDirty     = true;
        
        __drawOrder = [];
        __drawDirty = true;
        
        __dirtyOrderArray = [];
        
        __scissorStack = [];
        
        if ((os_type == os_switch)
        ||  (os_type == os_ps4)
        ||  (os_type == os_ps5)
        ||  (os_type == os_xboxone)
        ||  (os_type == os_xboxseriesxs))
        {
            __navMode = GUI_NAV_DIRECTIONAL;
        }
        else if ((os_type == os_android)
              || (os_type == os_ios)
              || (os_type == os_tvos))
        {
            __navMode = GUI_NAV_TOUCH;
        }
        else if ((os_type == os_windows)
              || (os_type == os_macosx)
              || (os_type == os_linux))
        {
            __navMode = GUI_DESKTOP_DEFAULT_TO_DIRECTIONAL? GUI_NAV_DIRECTIONAL : GUI_NAV_MOUSE;
        }
        else
        {
            __navMode = GUI_NAV_MOUSE;
        }
        
        __navPointer = false;
        
        __mouseX        = 0;
        __mouseY        = 0;
        __mouseHold     = false;
        __mousePrevX    = 0;
        __mousePrevY    = 0;
        __mousePrevHold = false;
        __mousePressX   = undefined;
        __mousePressY   = undefined;
        
        __directionalNavPreDelay     = 20;
        __directionalNavDelay        = 9;
        __directionalNavDelayCount   = 4;
        __directionalNavDelayShorter = 5;
        __directionalStateX          = new __GuiClassDirectionalState();
        __directionalStateY          = new __GuiClassDirectionalState();
        
        __directionalLastX    = 0;
        __directionalLastY    = 0;
        __directionalDX       = 0;
        __directionalDY       = 0;
        __directionalHold     = false;
        __directionalPrevHold = false;
        
        __overInstance     = noone;
        __overInstanceSoft = noone;
        __holdState        = GUI_OFF;
        __holdInstance     = noone;
        __popUpRoot        = noone;
        
        __buttonInputMap    = ds_map_create();
        __buttonPrevMap     = ds_map_create();
        __buttonStateMap    = ds_map_create();
        __buttonConsumedMap = ds_map_create();
        __buttonArray       = [];
        
        __primaryConsumed = false;
        
        __updateInstanceArray = [];
        
        __nameMap = ds_map_create();
        
        __tempParent = undefined;
        __tempInside = false;
        
        __animCount = 0;
        
        __freeze = false;
        __freezeOnAnimation = true;
        
        __tabDict = {};
        
        __memoryStruct = {};
    }
    
    if (GM_build_type == "run")
    {
        global.GuiSystem = _system;
    }
    
    return _system;
}