/// A vertical slider. Available in .ui script using the BentoVerticalSlider builder.
/// 
/// Sliders have two special callbacks, "onValueChange" and "valueUpdate":
/// 
/// "onValueChange" is executed when the handle is moved by the player. You could use this callback
/// to set a variable elsewhere or to play a sound etc. "valueUpdate" is called once when the
/// slider is created, and then every frame. The intention is that this callback allows you to
/// create a two-way binding for the slider. The function you set for "valueUpdate" should return 
/// the value you want to set for the slider. For example:
/// 
///     build BentoVerticalSlider {
///         onValueChange = fn {
///             SettingsSet("sound volume", value)
///             AudioPlay(snd_blip)
///         }
///     
///         valueUpdate = fn {
///             return SettingsGet("sound volume")
///         }
///     }
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name                  | Datatype | Purpose                                                                           |
/// |-----------------------|----------|-----------------------------------------------------------------------------------|
/// | color                 | RGB      | Colour for the slider                                                             |
/// | alpha                 | number   | Alpha blending value                                                              |
/// | handleWidth           | number   | Width of the handle                                                               |
/// | handleHeight          | number   | Height of the handle                                                              |
/// | handlePosition        | number   | Normalised (0 -> 1) position of the handle. Coupled to the .value variable        |
/// | value                 | number   | Value for the slider. Coupled to the .handlePosition variable                     |
/// | valueMin              | number   | Minimum value when the handle is at the top position                              |
/// | valueMax              | number   | Maximum value when the handle is at the bottom position                           |
/// | valueIncrement        | boolean  | Quantisation resolution for the slider value                                      |
/// | callbackOnValueChange | function | Callback to execute when the handle of the slider is moved                        |
/// | callbackValueUpdate   | function | Callback to execute every frame to link the slider to a variable stored elsewhere |

BentoAddBoxType("BentoVerticalSlider", BentoClassVerticalSlider, false);
function BentoClassVerticalSlider() : BentoClassButton() constructor
{
    /// Public variables ///
    focusable      = true;
    handleWidth    = undefined;
    handleHeight   = undefined;
    handlePosition = 0;
    value          = undefined;
    valueMin       = 0;
    valueMax       = 1;
    valueIncrement = 0.00001;
    ////////////////////////
    
    __localCaptureX = 0;
    __localCaptureY = 0;
    __handleLeft    = 0;
    __handleTop     = 0;
    __handleRight   = 0;
    __handleBottom  = 0;
    
    VariableBind("callbackOnValueChange", function()
    {
        __BentoError("Cannot get \"callbackOnValueChange\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__ON_VALUE_CHANGE, _value);
    });
    
    VariableBind("callbackValueUpdate", function()
    {
        __BentoError("Cannot get \"callbackValueUpdate\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__VALUE_UPDATE, _value);
    });
    
    static __UpdateHandle = function(_forceFromHandle)
    {
        var _oldValue = value;
        
        if ((value == undefined) || _forceFromHandle)
        {
            value = valueMin + valueIncrement*round(((valueMax - valueMin)*handlePosition) / valueIncrement);
        }
        else
        {
            value = valueMin + valueIncrement*round((value - valueMin) / valueIncrement);
        }
        
        handlePosition = clamp((value - valueMin) / (valueMax - valueMin), 0, 1);
        
        __handleLeft   = 0.5*(__localWidth - handleWidth);
        __handleTop    = handlePosition*max(0, __localHeight - handleHeight);
        __handleRight  = 0.5*(__localWidth + handleWidth);
        __handleBottom = __handleTop + handleHeight;
        
        //If the output value of the slider has changed, execute the associated callback
        if ((value != undefined) && (value != _oldValue))
        {
            __CallbackGet(__BENTO_CALL.__ON_VALUE_CHANGE).__Call(self, value);
        }
    }
    
    CallbackSetButtonStart(function()
    {
        BentoCallInherited();
        
        var _handleLeft  = __localX - 0.5*handleWidth;
        var _handleTop   = __worldTop + handlePosition*max(0, __localHeight - handleHeight);
        
        __localCaptureX = BentoPointerGetX() - _handleLeft;
        __localCaptureY = BentoPointerGetY() - _handleTop;
    });
    
    CallbackSetCanHighlight(function()
    {
        return point_in_rectangle(BentoPointerGetX() - __worldLeft, BentoPointerGetY() - __worldTop,
                                  __handleLeft, __handleTop, __handleRight, __handleBottom);
    });
    
    CallbackSetButtonCanCapture(function()
    {
        return point_in_rectangle(BentoPointerGetX() - __worldLeft, BentoPointerGetY() - __worldTop,
                                  __handleLeft, __handleTop, __handleRight, __handleBottom);
    });
    
    CallbackSetButton(function()
    {
        var _newTop = BentoPointerGetY();
        _newTop -= __localCaptureY;
        _newTop -= __worldTop;
        
        handlePosition = clamp(_newTop / max(1, __localHeight - handleHeight), 0, 1);
        
        __UpdateHandle(true);
    });
    
    CallbackSetOnClose(function()
    {
        if (handleWidth  == undefined) handleWidth  = __localWidth;
        if (handleHeight == undefined) handleHeight = 0.1*__localHeight;
        
        //Initialize the handle's position
        if (__CallbackExists(__BENTO_CALL.__VALUE_UPDATE)) value = __CallbackGet(__BENTO_CALL.__VALUE_UPDATE).__Call(self) ?? value;
        
        __UpdateHandle(false);
    });
    
    CallbackSetDraw(function()
    {
        //Update the slider by executing the value_update() function
        var _oldValue = value;
        var _newValue = __CallbackGet(__BENTO_CALL.__VALUE_UPDATE).__Call(self) ?? _oldValue;
        
        if (_newValue != _oldValue)
        {
            value = _newValue;
            __UpdateHandle(false);
        }
        
        var _sliderX     = 0.5*(__drawLeft + __drawRight);
        var _trackTop    = __drawTop;
        var _trackBottom = __drawBottom;
        
        var _handleLeft   = __handleLeft   + __drawLeft;
        var _handleTop    = __handleTop    + __drawTop;
        var _handleRight  = __handleRight  + __drawLeft;
        var _handleBottom = __handleBottom + __drawTop;
        
        var _color = merge_color(color, animBlend, animBlendAmount);
        var _alpha = alpha*animAlpha;
        
        var _oldColor = draw_get_color();
        var _oldAlpha = draw_get_alpha();
        
        draw_set_color(color);
        draw_set_alpha(alpha);
        
        if (_handleTop   > _trackTop    ) draw_line(_sliderX, _trackTop,     _sliderX, _handleTop  );
        if (_trackBottom > _handleBottom) draw_line(_sliderX, _handleBottom, _sliderX, _trackBottom);
        
        draw_set_color(c_black);
        draw_set_alpha(1);
        draw_rectangle(_handleLeft, _handleTop, _handleRight, _handleBottom, false);
        
        draw_set_color(_color);
        
        if (GetButton() || GetFocus())
        {
            draw_set_alpha(0.5*_alpha);
            draw_rectangle(_handleLeft, _handleTop, _handleRight, _handleBottom, false);
        }
        else if (GetHighlight())
        {
            draw_set_alpha(0.25*_alpha);
            draw_rectangle(_handleLeft, _handleTop, _handleRight, _handleBottom, false);
        }
        
        if (_alpha > 0)
        {
            draw_set_alpha(_alpha);
            draw_rectangle(_handleLeft, _handleTop, _handleRight, _handleBottom, true);
        }
        
        draw_set_color(_oldColor);
        draw_set_alpha(_oldAlpha);
    });
}