/// A horizontal scrollbar. Available in BentoScript using the BentoHorizontalScrollbar builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name    | Datatype  | Purpose                                                                 |
/// |---------|-----------|-------------------------------------------------------------------------|
/// | color   | RGB       | Colour for the slider                                                   |
/// | alpha   | number    | Alpha blending value                                                    |
/// | binding | UI struct | UI scroll box struct to bind to, as created by a BentoScrollBox builder |

BentoAddBoxType("BentoHorizontalScrollbar", BentoClassHorizontalScrollbar, false);
function BentoClassHorizontalScrollbar() : BentoClassHorizontalSlider() constructor
{
    __binding = undefined;
    
    VariableBind("value", function()
    {
        return value;
    },
    function(_value)
    {
        __BentoError("Cannot set \"value\" for scrollbars (set .scrollX for the scrollbox instead)");
    });
    
    VariableBind("valueMin", function()
    {
        return valueMin;
    },
    function(_value)
    {
        __BentoError("Cannot set .valueMin for scrollbars (set .scrollXMin for the scrollbox instead)");
    });
    
    VariableBind("valueMax", function()
    {
        return valueMax;
    },
    function(_value)
    {
        __BentoError("Cannot set .valueMax for scrollbars (set .scrollXMax for the scrollbox instead)");
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
        value     = _value.scrollX;
        valueMin  = _value.scrollXMin;
        valueMax  = _value.scrollXMax;
    });
    
    EventOnValueChange(function(_value)
    {
        if (__binding != undefined) __binding.scrollX = _value;
    });
    
    EventValueUpdate(function()
    {
        if (__binding != undefined)
        {
            valueMin = __binding.scrollXMin;
            valueMax = __binding.scrollXMax;
            
            return __binding.scrollX;
        }
    });
}