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
    
    __envMouseX     = 0;
    __envMouseY     = 0;
    __envMouseHold  = false;
    __envMouseState = __BENTO_STATE_OFF;
    
    __envNavigationDX    = 0;
    __envNavigationDY    = 0;
    __envNavigationHold  = false;
    __envNavigationState = __BENTO_STATE_OFF;
    
    __envHotkeyInputMap = ds_map_create();
    
    ///////
    // Set up a default input mode for convenience
    ///////
    
    if ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_ps5) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        //Default to gamepad input on console
        __envInputMode = BENTO_MODE_GAMEPAD;
    }
    else if ((os_type == os_android) || (os_type == os_ios) || (os_type == os_tvos))
    {
        //Default to touch on mobile
        __envInputMode = BENTO_MODE_TOUCH;
    }
    else if ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))
    {
        //Let the developer decide what to do on desktop
        __envInputMode = BENTO_DESKTOP_DEFAULT_INPUT_MODE;
    }
    else
    {
        __BentoTrace("Warning! OS not supported. Guessing that gamepad control is intended");
        __envInputMode = BENTO_MODE_GAMEPAD;
    }
    
    if (BENTO_DEBUG_LEVEL >= 1)
    {
        __BentoTrace($"Input mode for environment {__BentoGetStructPointer(self)} defaults to {__BentoGetInputModeName(__envInputMode)} based on the current OS ({os_type})");
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
    __newLayerArray = [];
    
    __nameMap = ds_map_create();
    
    ///////
    // Other Stuff
    ///////
    
    //Initialize to some guesswork values
    __approxWidth  = window_get_width();
    __approxHeight = window_get_height();
    
    
    
    
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
        
        array_resize(__newLayerArray, 0);
    }
    
    static __RemoveLayer = function(_layer)
    {
        var _index = array_get_index(__layerArray, _layer);
        if (_index >= 0)
        {
            array_delete(__layerArray, _index, 1);
            
            //Foreground the next top element
            var _last = array_last(__layerArray);
            if (_last != undefined) _last.__SetForegroundedState();
        }
        
        var _index = array_get_index(__newLayerArray, _layer);
        if (_index >= 0) array_delete(__newLayerArray, _index, 1);
    }
    
    static __Update = function(_rootX, _rootY, _rootWidth, _rootHeight, _timeStep)
    {
        __approxWidth  = _rootWidth;
        __approxHeight = _rootHeight;
        
        var _layerArray = __layerArray;
        
        //Advance mouse and navigation state
        __envMouseState = __envMouseState >> 1;
        if (__envMouseHold) __envMouseState |= __BENTO_STATE_START;
        
        __envNavigationState = __envNavigationState >> 1;
        if (__envNavigationHold) __envNavigationState |= __BENTO_STATE_START;
        
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
        
        array_resize(__newLayerArray, 0);
        
        //Execute updates for all layers
        var _i = 0;
        repeat(_layerCount)
        {
            _layerArray[_i].__Update(_rootX, _rootY, _rootWidth, _rootHeight, _timeStep);
            ++_i;
        }
        
        //Do a partial update of any new layers
        var _i = 0;
        repeat(array_length(__newLayerArray))
        {
            __newLayerArray[_i].__UpdatePartialOnCreate(_rootX, _rootY, _rootWidth, _rootHeight);
            ++_i;
        }
        
        //Wipe out the hotkeys, nullifying them for the next update loop
        ds_map_clear(__envHotkeyInputMap);
        
        __BentoEnvironmentTargetPop();
    }
    
    static __Draw = function()
    {
        __BentoEnvironmentTargetPush(self);
        
        var _layerArray = __layerArray;
        if (array_length(_layerArray) > 0)
        {
            var _i = 0;
            repeat(array_length(_layerArray))
            {
                _layerArray[_i].__Draw();
                ++_i;
            }
        }
        
        __BentoEnvironmentTargetPop();
    }
}