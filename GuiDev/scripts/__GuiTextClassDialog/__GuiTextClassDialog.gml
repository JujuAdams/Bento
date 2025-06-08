// Feather disable all

/// @param initialText
/// @param caption
/// @param maxLength

function __GuiTextClassDialog(_initialText, _caption, _maxLength) constructor
{
    _initialText = string_copy(_initialText, 1, _maxLength);
    
    static _system = __GuiTextSystem();
    //Don't set `__text` here. We only set `__text` when the player confirms the dialog
    _system.__state = GUI_TEXT_PENDING;
    
    __caption   = _caption;
    __maxLength = _maxLength;
    
    __timeSource = undefined;
    
    __asyncID = get_string_async(_caption, _initialText);
    if (__asyncID >= 0)
    {
        __GuiTextEnsureController().__dialog = self;
    }
    else
    {
        show_debug_message("Failed to open dialog window");
        __Terminate(GUI_TEXT_ABORT);
        return;
    }
    
    //Create a time source to ensure the controller is still alive
    __timeSource = time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        if (_system.__state == GUI_TEXT_PENDING)
        {
            __GuiTextEnsureController().__dialog = self;
        }
    },
    [], -1);
    time_source_start(__timeSource);
    
    static __AsyncEvent = function()
    {
        if (async_load[? "id"] == __asyncID)
        {
            var _result = async_load[? "result"];
            if ((not async_load[? "status"]) || (_result == undefined))
            {
                __Terminate(GUI_TEXT_ABORT);
            }
            else
            {
                _system.__text = string_copy(_result, 1, __maxLength);
                __Terminate(GUI_TEXT_CONFIRM);
            }
        }
    }
    
    static __Terminate = function(_state)
    {
        _system.__state = _state;
        
        __asyncID = undefined;
        
        if (__timeSource != undefined)
        {
            time_source_stop(__timeSource);
            time_source_destroy(__timeSource);
            __timeSource = undefined;
        }
        
        with(__GuiTextAsyncController)
        {
            __dialog = undefined;
            instance_destroy();
        }
    }
}