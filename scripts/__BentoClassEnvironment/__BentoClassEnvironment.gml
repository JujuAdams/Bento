// Feather disable all

/// @param name

function __BentoClassEnvironment(_name) constructor
{
    static _system = __BentoSystem();
    
    __name = _name;
    
    if (BENTO_DEBUG_LEVEL >= 1)
    {
        __BentoTrace($"Creating environment {__BentoGetStructPointer(self)} called \"{__name}\"");
    }
    
    ///////
    // Raw input tracking
    ///////
    
    __envMouseX    = 0;
    __envMouseY    = 0;
    __envMouseHold = false;
    
    __envDirectionalDX   = 0;
    __envDirectionalDY   = 0;
    __envDirectionalHold = false;
    
    __envHotkeyInputMap = ds_map_create();
    
    ///////
    // Set up a default input mode for convenience
    ///////
    
    if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_ps5) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        //Default to gamepad input on console
        __envNavMode = BENTO_MODE_GAMEPAD;
    }
    else if ((os_type == os_android) || (os_type == os_ios) || (os_type == os_tvos))
    {
        //Default to touch on mobile
        __envNavMode = BENTO_MODE_TOUCH;
    }
    else if ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))
    {
        //Let the developer decide what to do on desktop
        __envNavMode = BENTO_DESKTOP_DEFAULT_NAV_MODE;
    }
    else
    {
        __BentoTrace("Warning! OS not supported. Guessing that gamepad control is intended");
        __envNavMode = BENTO_MODE_GAMEPAD;
    }
    
    if (BENTO_DEBUG_LEVEL >= 1)
    {
        __BentoTrace($"Input mode for environment {__BentoGetStructPointer(self)} defaults to {__BentoGetInputModeName(__envNavMode)} based on the current OS ({os_type})");
    }
    
    ///////
    // Text input tracking
    ///////
    
    __textElement = undefined;
    __textHandler = undefined;
    
    ///////
    // Layers!
    ///////
    
    __layerCurrent = new __BentoClassLayer(self, "default");
    __layerArray = [__layerCurrent];
    
    __nameMap = ds_map_create();
    
    
    
    
    
    static __Destroy = function()
    {
        if (BENTO_DEBUG_LEVEL >= 1)
        {
            __BentoTrace($"Destroying environment {__BentoGetStructPointer(self)} called \"{__name}\"");
        }
        
        var _index = array_get_index(_system.__environmentArray, self);
        if (_index >= 0) array_delete(_system.__environmentArray, _index, 1);
        
        var _layerArray = __layerArray;
        
        var _i = array_length(_layerArray)-1;
        repeat(array_length(_layerArray))
        {
            _layerArray[_i].__Destroy();
            --_i;
        }
    }
    
    static __RemoveLayer = function(_layer)
    {
        var _index = array_get_index(__layerArray, _layer);
        if (_index >= 0) array_delete(__layerArray, _index, 1);
    }
    
    static __Update = function(_rootX, _rootY, _rootWidth, _rootHeight, _timeStep)
    {
        var _layerArray = __layerArray;
        
        var _layerCount = array_length(_layerArray);
        if (_layerCount <= 0) return;
        
        __BentoEnvironmentTargetPush(self);
        
        //Update any text input
        if (__textHandler != undefined)
        {
            if (BentoExists(__textElement))
            {
                __BentoLayerTargetPush(__textElement.BENTO_VARS.__layer);
                __textHandler.__Step();
                __BentoLayerTargetPop();
            }
            else
            {
                __textHandler.__Terminate(BENTO_TEXT_INACTIVE);
            }
        }
        
        //All lower layers only ensure layouts etc.
        var _i = 0;
        repeat(_layerCount-1)
        {
            _layerArray[_i].__Update(_rootX, _rootY, _rootWidth, _rootHeight, false, _timeStep);
            ++_i;
        }
        
        //Top-most layer pulls in player input
        _layerArray[_i].__Update(_rootX, _rootY, _rootWidth, _rootHeight, true, _timeStep);
        
        //Wipe out the hotkeys, nullifying them for the next update loop
        ds_map_clear(__envHotkeyInputMap);
        
        __BentoEnvironmentTargetPop();
    }
    
    static __Draw = function()
    {
        __BentoEnvironmentTargetPush(self);
        
        var _layerArray = __layerArray;
        var _i = 0;
        repeat(array_length(_layerArray))
        {
            _layerArray[_i].__Draw();
            ++_i;
        }
        
        __BentoEnvironmentTargetPop();
    }
}