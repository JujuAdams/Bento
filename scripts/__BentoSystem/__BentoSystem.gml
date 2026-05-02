// Feather disable all

/// Initializes a global struct that contains library state.

//Many GM functions don't support using `infinity`
#macro __BENTO_VERY_LARGE  999999

#macro __BENTO_NO_PARENT  -666

#macro __BENTO_STATE_OFF    0b00  //0
#macro __BENTO_STATE_START  0b10  //2
#macro __BENTO_STATE_ON     0b11  //3
#macro __BENTO_STATE_END    0b01  //1

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
        
        ///////
        // Draw method lookup arrays
        ///////
        
        __functionDrawLookupArray      = array_create((__BENTO_DRAW_ORDER_MATRIX << 1), undefined);
        __functionDrawAfterLookupArray = array_create((__BENTO_DRAW_ORDER_MATRIX << 1), undefined);
        
        if (BENTO_RUNNING_FROM_IDE)
        {
            __functionDrawLookupMap = ds_map_create();
        }
        
        var _funcAddDrawFunction = function(_array, _index, _name, _function)
        {
            _array[@ _index] = _function;
            
            if (BENTO_RUNNING_FROM_IDE && is_callable(_function))
            {
                var _method = method(self, _function);
                var _handle = method_get_index(_method);
                
                __functionDrawLookupMap[? _function] = _name;
                __functionDrawLookupMap[? _handle  ] = _name;
            }
        }
        
        _funcAddDrawFunction(__functionDrawLookupArray, 0, "null", undefined);
        
        _funcAddDrawFunction(__functionDrawLookupArray, __BENTO_DRAW_ORDER_SCISSOR, "scissor push", function()
        {
            __BentoDrawScissorPushFromVars();
        });
        
        _funcAddDrawFunction(__functionDrawLookupArray, __BENTO_DRAW_ORDER_MATRIX, "transform push", function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
        });
        
        _funcAddDrawFunction(__functionDrawLookupArray, __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX, "transform push, scissor push", function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            __BentoDrawScissorPushFromVars();
        });
        
        _funcAddDrawFunction(__functionDrawLookupArray, __BENTO_DRAW_ORDER_VISIBLE, "draw", function()
        {
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDraw();
            }
        });
        
        _funcAddDrawFunction(__functionDrawLookupArray, __BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR, "draw, scissor push", function()
        {
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDraw();
            }
            
            __BentoDrawScissorPushFromVars();
        });
        
        _funcAddDrawFunction(__functionDrawLookupArray, __BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_MATRIX, "transform push, draw", function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDraw();
            }
        });
        
        _funcAddDrawFunction(__functionDrawLookupArray, __BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX, "transform push, draw, scissor push", function()
        {
            matrix_stack_push(__transformMatrix);
            matrix_set(matrix_world, matrix_stack_top());
            
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDraw();
            }
            
            __BentoDrawScissorPushFromVars();
        });
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, 0, "null", undefined);
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, __BENTO_DRAW_ORDER_SCISSOR, "scissor pop", function()
        {
            __BentoDrawScissorPop();
        });
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, __BENTO_DRAW_ORDER_MATRIX, "transform pop", function()
        {
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        });
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX, "scissor pop, transform pop", function()
        {
            __BentoDrawScissorPop();
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        });
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, __BENTO_DRAW_ORDER_VISIBLE, "draw", function()
        {
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDrawAfter();
            }
        });
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, __BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR, "scissor pop, drawAfter", function()
        {
            __BentoDrawScissorPop();
            
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDrawAfter();
            }
        });
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, __BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_MATRIX, "drawAfter, transform pop", function()
        {
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDrawAfter();
            }
            
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        });
        
        _funcAddDrawFunction(__functionDrawAfterLookupArray, __BENTO_DRAW_ORDER_VISIBLE | __BENTO_DRAW_ORDER_SCISSOR | __BENTO_DRAW_ORDER_MATRIX, "scissor pop, drawAfter, transform pop", function()
        {
            __BentoDrawScissorPop();
            
            if (__scissorVisibility != BENTO_VISIBLE_NONE)
            {
                __eventDrawAfter();
            }
            
            matrix_stack_pop();
            matrix_set(matrix_world, matrix_stack_top());
        });
        
        ///////
        // Variable declaration
        ///////
        
        __globalScale = 1;
        
        __skinDict = {};
        
        __scissorStack = [];
        
        __creatingObject = false;
        __tempParent     = BENTO_NO_ELEMENT;
        
        __globalDirPreDelay     = 20;
        __globalDirDelay        = 9;
        __globalDirDelayCount   = 4;
        __globalDirDelayShorter = 5;
        
        __globalScissorXOffset = 0;
        __globalScissorYOffset = 0;
        __globalScissorXScale  = 1;
        __globalScissorYScale  = 1;
        
        __environmentArray = [];
        var _environment = BentoEnvironmentCreate("default");
        
        __environmentStack   = [];
        __environmentCurrent = _environment;
        
        __layerStack   = [];
        __layerCurrent = __environmentCurrent.__layerCurrent;
        
        __textUseSteamKeyboard   = false;
        __textHandlerEnvironment = undefined;
        
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            ++__frame;
        },
        [], -1));
    }
    
    if (BENTO_RUNNING_FROM_IDE)
    {
        global.BentoElementMap = ds_map_create();
        global.BentoSystem = _system;
    }
    
    return _system;
}