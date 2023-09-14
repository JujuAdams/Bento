BentoAddBoxType("BentoVerticalScrollbar", BentoClassVerticalScrollbar, false);
function BentoClassVerticalScrollbar() : BentoClassVerticalSlider() constructor
{
    /// Public variables ///
    
    ////////////////////////
    
    __binding = undefined;
    
    VariableBind("value", function()
    {
        return value;
    },
    function(_value)
    {
        __BentoError("Cannot set \"value\" for scrollbars (set .scrollY for the scrollbox instead)");
    });
    
    VariableBind("valueMin", function()
    {
        return valueMin;
    },
    function(_value)
    {
        __BentoError("Cannot set .valueMin for scrollbars (set .scrollYMin for the scrollbox instead)");
    });
    
    VariableBind("valueMax", function()
    {
        return valueMax;
    },
    function(_value)
    {
        __BentoError("Cannot set .valueMax for scrollbars (set .scrollYMax for the scrollbox instead)");
    });
    
    VariableBind("binding", function()
    {
        return __binding;
    },
    function(_value)
    {
        if (not is_struct(_value)) __BentoError("Must bind to a BentoScrollBox (type=", typeof(_value), ")");
        
        if (typeof(_value) != "BentoScrollBox")
        {
            try
            {
                var _ = _value.__captureClipChildren;
                    _ = _value.__surface;
                    _ = _value.__scrollDragOffsetX;
                    _ = _value.__scrollDragOffsetY;
            }
            catch(_error)
            {
                __BentoError("Must bind to a BentoScrollBox (type=", typeof(_value), ")");
            }
        }
        
        __binding = _value;
        value    = _value.scrollY;
        valueMin = _value.scrollYMin;
        valueMax = _value.scrollYMax;
    });
    
    CallbackSetOnValueChange(function(_value)
    {
        if (__binding != undefined) __binding.scrollY = _value;
    });
    
    CallbackSetValueUpdate(function()
    {
        if (__binding != undefined)
        {
            valueMin = __binding.scrollYMin;
            valueMax = __binding.scrollYMax;
            
            return __binding.scrollY;
        }
    });
}