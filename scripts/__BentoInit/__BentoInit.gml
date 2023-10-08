#macro BENTO_ANIMATION_ENTERED  0
#macro BENTO_ANIMATION_ENTER    1
#macro BENTO_ANIMATION_EXIT     2
#macro BENTO_ANIMATION_EXITED   3

#macro BENTO_BEHAVIOR_DRAW_ONLY    0
#macro BENTO_BEHAVIOR_PASSTHROUGH  1
#macro BENTO_BEHAVIOR_MODAL        2
#macro BENTO_BEHAVIOR_BLOCKING     3

#macro BENTO_INPUT_MODE_POINTER      "pointer"
#macro BENTO_INPUT_MODE_DIRECTIONAL  "directional"

#macro BENTO_VERSION  "0.1.5 alpha"
#macro BENTO_DATE     "2023-10-07"

#macro __BENTO_TEST_FOCUSING  true

enum __BENTO_EVENT
{
    __HIGHLIGHT_START,
    __HIGHLIGHT,
    __HIGHLIGHT_END,
    
    __BUTTON_START,
    __BUTTON,
    __BUTTON_END,
    __BUTTON_CLICK,
    __BUTTON_LONG_CLICK,
    __BUTTON_CAN_CAPTURE,
    
    __PUSH,
    
    __STEP,
    __DRAW,
    __ON_CLOSE,
    __DESTROY,
    __CAN_HIGHLIGHT,
    __LAYOUT,
    
    __ON_VALUE_CHANGE,
    __VALUE_UPDATE,
    
    __ANIMATION_ENTER,
    __ANIMATION_ENTERED,
    __ANIMATION_EXIT,
    __ANIMATION_EXITED,
    
    __SIZE,
    
    __CATEGORY_HIGHLIGHT,
    __CATEGORY_BUTTON,
    __CATEGORY_ANY_INTERACTION,
}

__BentoInit();

function __BentoInit()
{
    static _initialized = false;
    if (_initialized) return;
    _initialized = true;
    
    __BentoValidateMacros();
    __BentoTrace("Welcome to Bento by Juju Adams! This is version " + BENTO_VERSION + ", " + BENTO_DATE);
    
    __BentoScriptForceInit();
    
    var _global = __BentoGlobal();
    if (GM_build_type == "run") global.bentoDebug = _global;
    
    if ((BENTO_HOT_RELOAD_MODE > 0) && (GM_build_type == "run")) _global.__fileDirectory = filename_dir(GM_project_filename) + "/datafiles/";
    
    _global.__nullEvent    = new __BentoClassEvent(undefined, undefined, false, undefined);
    _global.__currentEvent = _global.__nullEvent;
    
    _global.__bentoScriptEnv = __BentoScript;
    _global.__defaultHost = BentoHostCreate("master");
    BentoHostResetTarget();
    
    __BentoInitEnvironment();
    
    time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        __BentoSurfaceCheckForOrphans();
    }, [], -1));
    
    if (((BENTO_HOT_RELOAD_MODE == 1) && (GM_build_type == "run")) || (BENTO_HOT_RELOAD_MODE == 2))
    {
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            __BentoCheckForChanges();
        }, [], -1));
    }
}