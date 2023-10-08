function __BentoSharedVariableBindings()
{
    #region Events
    
    #region General
    
    VariableBind("eventStep", function()
    {
        __BentoError("Cannot get \"eventStep\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__STEP, _value);
    });
    
    VariableBind("eventDraw", function()
    {
        __BentoError("Cannot get \"eventDraw\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__DRAW, _value);
    });
    
    VariableBind("eventDestroy", function()
    {
        __BentoError("Cannot get \"eventDestroy\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__DESTROY, _value);
    });
    
    VariableBind("eventOnClose", function()
    {
        __BentoError("Cannot get \"eventOnClose\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__ON_CLOSE, _value);
    });
    
    VariableBind("eventLayout", function()
    {
        __BentoError("Cannot get \"eventLayout\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__LAYOUT, _value);
    });
    
    VariableBind("eventPush", function()
    {
        __BentoError("Cannot get \"eventPush\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__PUSH, _value);
    });
    
    #endregion
    
    #region Animations
    
    VariableBind("eventAnimationEnter", function()
    {
        __BentoError("Cannot get \"eventAnimationEnter\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__ANIMATION_ENTER, _value);
    });
    
    VariableBind("eventAnimationEntered", function()
    {
        __BentoError("Cannot get \"eventAnimationEntered\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__ANIMATION_ENTERED, _value);
    });
    
    VariableBind("eventAnimationExit", function()
    {
        __BentoError("Cannot get \"eventAnimationExit\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__ANIMATION_EXIT, _value);
    });
    
    VariableBind("eventAnimationExited", function()
    {
        __BentoError("Cannot get \"eventAnimationExited\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__ANIMATION_EXITED, _value);
    });
    
    #endregion
    
    #region Button / Clicking
    
    VariableBind("eventPress", function()
    {
        __BentoError("Cannot get \"eventPress\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__BUTTON_START, _value);
    });
    
    VariableBind("eventHold", function()
    {
        __BentoError("Cannot get \"eventHold\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__BUTTON, _value);
    });
    
    VariableBind("eventRelease", function()
    {
        __BentoError("Cannot get \"eventRelease\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__BUTTON_END, _value);
    });
    
    VariableBind("eventClick", function()
    {
        __BentoError("Cannot get \"eventClick\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__BUTTON_CLICK, _value);
    });
    
    VariableBind("eventLongClick", function()
    {
        __BentoError("Cannot get \"eventLongClick\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__BUTTON_LONG_CLICK, _value);
    });
    
    VariableBind("eventCanCapture", function()
    {
        __BentoError("Cannot get \"eventCanCapture\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__BUTTON_CAN_CAPTURE, _value);
    });
    
    VariableBind("targetListen", function()
    {
        __BentoError("Cannot get \"targetListen\"");
        return;
    },
    function(_array)
    {
        if (not is_array(_array)) _array = [_array];
        
        var _i = 0;
        repeat(array_length(_array))
        {
            var _value = _array[_i];
            
            if (!variable_struct_exists(__listenTargetDict, _value))
            {
                array_push(__listenTargetArray, _value);
                __listenTargetDict[$ _value] = true;
            }
            
            ++_i;
        }
    });
    
    VariableBind("castListen", function()
    {
        __BentoError("Cannot get \"castListen\"");
        return;
    },
    function(_array)
    {
        if (not is_array(_array)) _array = [_array];
        
        var _i = 0;
        repeat(array_length(_array))
        {
            var _value = _array[_i];
            
            if (!variable_struct_exists(__listenCastDict, _value))
            {
                array_push(__listenCastArray, _value);
                __listenCastDict[$ _value] = true;
            }
            
            ++_i;
        }
    });
    
    #endregion
    
    #region Pointer-Over / Highlight
    
    VariableBind("eventEnter", function()
    {
        __BentoError("Cannot get \"eventEnter\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__HIGHLIGHT_START, _value);
    });
    
    VariableBind("eventOver", function()
    {
        __BentoError("Cannot get \"eventOver\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__HIGHLIGHT, _value);
    });
    
    VariableBind("eventLeave", function()
    {
        __BentoError("Cannot get \"eventLeave\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__HIGHLIGHT_END, _value);
    });
    
    VariableBind("eventCanHighlight", function()
    {
        __BentoError("Cannot get \"eventCanHighlight\"");
        return;
    },
    function(_value)
    {
        __EventFromBentoScript(__BENTO_EVENT.__CAN_HIGHLIGHT, _value);
    });
    
    #endregion
    
    #endregion
    
    
    
    #region Local Position Variable Bindings
    
    VariableBind("left", function()
    {
        return __localLeft;
    },
    function(_value)
    {
        __localLeft  = __PercentageWidth(_value);
        __localWidth = __localRight - __localLeft;
        __localX     = lerp(__localLeft, __localRight, __originX);
        
        TempOriginXReset();
    });
    
    VariableBind("top", function()
    {
        return __localTop;
    },
    function(_value)
    {
        __localTop    = __PercentageHeight(_value);
        __localHeight = __localBottom - __localTop;
        __localY      = lerp(__localTop, __localBottom, __originY);
        
        TempOriginYReset();
    });
    
    VariableBind("right", function()
    {
        return __localRight;
    },
    function(_value)
    {
        __localRight = __PercentageWidth(_value);
        __localWidth = __localRight - __localLeft;
        __localX     = lerp(__localLeft, __localRight, __originX);
        
        TempOriginXReset();
    });
    
    VariableBind("bottom", function()
    {
        return __localBottom;
    },
    function(_value)
    {
        __localBottom = __PercentageHeight(_value);
        __localHeight = __localBottom - __localTop;
        __localY      = lerp(__localTop, __localBottom, __originY);
        
        TempOriginYReset();
    });
    
    VariableBind("x", function()
    {
        return __localX;
    },
    function(_value)
    {
        _value = __PercentageWidth(_value);
        
        var _delta = _value - __localX;
        __localLeft  += _delta;
        __localRight += _delta;
        __localX      = _value;
    });
    
    VariableBind("y", function()
    {
        return __localY;
    },
    function(_value)
    {
        _value = __PercentageHeight(_value);
        
        var _delta = _value - __localY;
        __localTop    += _delta;
        __localBottom += _delta;
        __localY       = _value;
    });
    
    VariableBind("xy", function()
    {
        return [Get("x"), Get("y")];
    },
    function(_array)
    {
        Set("x", _array[0]);
        Set("y", _array[1]);
    });
    
    VariableBind("width", function()
    {
        return __localWidth;
    },
    function(_value)
    {
        var _delta = __PercentageWidth(_value) - __localWidth;
        __localLeft  = __localLeft - __originX*_delta;
        __localRight = __localRight + (1 - __originX)*_delta;
        __localWidth = __localRight - __localLeft;
        
        TempOriginXReset();
    });
    
    VariableBind("height", function()
    {
        return __localHeight;
    },
    function(_value)
    {
        var _delta = __PercentageHeight(_value) - __localHeight;
        __localTop    = __localTop - __originY*_delta;
        __localBottom = __localBottom + (1 - __originY)*_delta;
        __localHeight = __localBottom - __localTop;
        
        TempOriginYReset();
    });
    
    VariableBind("originX", function()
    {
        return __originX;
    },
    function(_value)
    {
        __originXStashed = undefined;
        
        __originX = _value;
        __localX = lerp(__localLeft, __localRight, __originX);
    });
    
    VariableBind("originY", function()
    {
        return __originY;
    },
    function(_value)
    {
        __originYStashed = undefined;
        
        __originY = _value;
        __localY = lerp(__localTop, __localBottom, __originY);
    });
    
    VariableBind("origin", function()
    {
        return [Get("originX", "originY")];
    },
    function(_value)
    {
        Set("originX", _value[0]);
        Set("originY", _value[1]);
    });
    
    VariableBind("scale", function()
    {
        return __localScale;
    },
    function(_value)
    {
        __localScale = _value;
    });
    
    #endregion
    
    
    
    #region Multi-argument variables
    
    VariableBind("ltrb", function()
    {
        return [__localLeft, __localTop, __localRight, __localBottom];
    },
    function(_value)
    {
        var _originXStashed = __originXStashed;
        var _originYStashed = __originYStashed;
        Set("left",   _value[0]);
        Set("top",    _value[1]);
        
        __originXStashed = _originXStashed;
        __originYStashed = _originYStashed;
        Set("right",  _value[2]);
        Set("bottom", _value[3]);
    });
    
    VariableBind("size", function()
    {
        return [__localWidth, __localHeight];
    },
    function(_value)
    {
        Set("width",  _value[0]);
        Set("height", _value[1]);
    });
    
    VariableBind("xy", function()
    {
        return [__localX, __localY];
    },
    function(_value)
    {
        Set("x", _value[0]);
        Set("y", _value[1]);
    });
    
    VariableBind("xywh", function()
    {
        return [__localX, __localY, __localWidth, __localHeight];
    },
    function(_value)
    {
        Set("x",      _value[0]);
        Set("y",      _value[1]);
        Set("width",  _value[2]);
        Set("height", _value[3]);
    });
    
    #endregion
    
    
    
    #region World Position Getter/Setter
    
    VariableBind("worldLeft", function()
    {
        return __worldLeft;
    },
    function(_value)
    {
        _value = __PercentageWidth(_value);
        
        __worldLeft  = _value;
        
        __localLeft  = _value - 0.5*(__worldLeft + __worldRight) / __worldScale;
        __localWidth = __localRight - __localLeft;
    });
    
    VariableBind("worldTop", function()
    {
        return __worldTop;
    },
    function(_value)
    {
        _value = __PercentageHeight(_value);
        
        __worldTop    = _value;
        
        __localTop    = _value - 0.5*(__worldTop + __worldBottom) / __worldScale;
        __localHeight = __localBottom - __localTop;
    });
    
    VariableBind("worldRight", function()
    {
        return __worldRight;
    },
    function(_value)
    {
        _value = __PercentageWidth(_value);
        
        __worldRight = _value;
        
        __localRight = _value - 0.5*(__worldLeft + __worldRight) / __worldScale;
        __localWidth = __localRight - __localLeft;
    });
    
    VariableBind("worldBottom", function()
    {
        return __worldBottom;
    },
    function(_value)
    {
        _value = __PercentageHeight(_value);
        
        __worldBottom = _value;
        
        __localBottom = _value - 0.5*(__worldTop + __worldBottom) / __worldScale;
        __localHeight = __localBottom - __localTop;
    });
    
    VariableBind("worldX", function()
    {
        return lerp(__worldLeft, __worldRight, __originX);
    },
    function(_value)
    {
        _value = __PercentageWidth(_value);
        
        var _delta = _value - lerp(__worldLeft, __worldRight, __originX);
        __worldLeft  += _delta;
        __worldRight += _delta;
        __localLeft  += _delta / __worldScale;
        __localRight += _delta / __worldScale;
    });
    
    VariableBind("worldY", function()
    {
        return lerp(__worldTop, __worldBottom, __originY);
    },
    function(_value)
    {
        _value = __PercentageHeight(_value);
        
        var _delta = _value - lerp(__worldTop, __worldBottom, __originX);
        __worldTop    += _delta;
        __worldBottom += _delta;
        __localTop    += _delta / __worldScale;
        __localBottom += _delta / __worldScale;
    });
    
    VariableBind("worldWidth", function()
    {
        return __worldRight - __worldLeft;
    },
    function(_value)
    {
        var _localDelta = (__PercentageWidth(_value) / __worldScale) - __localWidth;
        
        __localLeft  = __localLeft - __originX*_localDelta;
        __localRight = __localRight + (1 - __originX)*_localDelta;
        __localWidth = __localRight - __localLeft;
        
        __worldLeft  = __localLeft  + __worldOffsetX;
        __worldRight = __localRight + __worldOffsetX;
        
        TempOriginXReset();
    });
    
    VariableBind("worldHeight", function()
    {
        return __worldBottom - __worldTop;
    },
    function(_value)
    {
        var _localDelta = (__PercentageHeight(_value) / __worldScale) - __localHeight;
        
        __localTop    = __localTop - __originY*_localDelta;
        __localBottom = __localBottom + (1 - __originY)*_localDelta;
        __localHeight = __localBottom - __localTop;
        
        __worldTop    = __localTop    + __worldOffsetY;
        __worldBottom = __localBottom + __worldOffsetY;
        
        TempOriginYReset();
    });
    
    #endregion
    
    
    
    #region Draw Position Getter
    
    VariableBind("drawLeft", function()
    {
        return __drawLeft;
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawLeft\"");
    });
    
    VariableBind("drawTop", function()
    {
        return __drawTop;
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawTop\"");
    });
    
    VariableBind("drawRight", function()
    {
        return __drawRight;
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawRight\"");
    });
    
    VariableBind("drawBottom", function()
    {
        return __drawBottom;
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawBottom\"");
    });
    
    VariableBind("drawX", function()
    {
        return 0.5*(__drawLeft + __drawRight);
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawX\"");
    });
    
    VariableBind("drawY", function()
    {
        return 0.5*(__drawTop + __drawBottom);
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawY\"");
    });
    
    VariableBind("drawWidth", function()
    {
        return (__drawRight - __drawLeft);
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawWidth\"");
    });
    
    VariableBind("drawHeight", function()
    {
        return (__drawBottom - __drawTop);
    },
    function(_value)
    {
        __BentoError("Cannot set \"drawHeight\"");
    });
    
    #endregion
    
    
    
    #region Navigation Getter/Setters
    
    VariableBind("navigationRight", function()
    {
        return __BentoNullableRefResolve(__navigationRight);
    },
    function(_value)
    {
        __navigationRight = __BentoNullableRefCreate(_value);
    });
    
    VariableBind("navigationUp", function()
    {
        return __BentoNullableRefResolve(__navigationUp);
    },
    function(_value)
    {
        __navigationUp = __BentoNullableRefCreate(_value);
    });
    
    VariableBind("navigationLeft", function()
    {
        return __BentoNullableRefResolve(__navigationLeft);
    },
    function(_value)
    {
        __navigationLeft = __BentoNullableRefCreate(_value);
    });
    
    VariableBind("navigationDown", function()
    {
        return __BentoNullableRefResolve(__navigationDown);
    },
    function(_value)
    {
        __navigationDown = __BentoNullableRefCreate(_value);
    });
    
    #endregion
    
    
    
    #region Other Getter/Setters
    
    VariableBind("children", function()
    {
        return __children;
    },
    function(_value)
    {
        __BentoError("Cannot set \"children\"");
    });
    
    VariableBind("parent", function()
    {
        return __parent;
    },
    function(_value)
    {
        __BentoError("Cannot set \"parent\"");
    });
    
    VariableBind("active", function()
    {
        return __active;
    },
    function(_value)
    {
        var _oldValue = __active;
        __active = _value;
        
        if (_oldValue && !__active)
        {
            var _layer = __FindLayer();
            if (_layer != undefined)
            {
                with(_layer)
                {
                    if (__BentoNullableRefResolve(__highlightRef) == other) __HighlightSet(undefined, false);
                    if (__BentoNullableRefResolve(__captureRef  ) == other) __CaptureSet(undefined, undefined);
                }
            }
        }
    });
    
    VariableBind("visible", function()
    {
        return __visible;
    },
    function(_value)
    {
        var _oldValue = __visible;
        __visible = _value;
        
        if (_oldValue && !__visible)
        {
            var _layer = __FindLayer();
            if (_layer != undefined)
            {
                with(_layer)
                {
                    if (__BentoNullableRefResolve(__highlightRef) == other) __HighlightSet(undefined, false);
                    if (__BentoNullableRefResolve(__captureRef  ) == other) __CaptureSet(undefined, undefined);
                }
            }
        }
    });
    
    #endregion
    
    
    
    #region Child Properties
    
    VariableBind("childMinLeft", function()
    {
        if (array_length(__children) <= 0) return __localLeft;
        
        var _value = __children[0].__localLeft;
        var _i = 1;
        repeat(array_length(__children)-1)
        {
            _value = min(_value, __children[_i].__localLeft);
            ++_i;
        }
        
        return _value;
    },
    function(_value)
    {
        __BentoError("Cannot set \"childMinLeft\"");
    });
    
    VariableBind("childMinTop", function()
    {
        if (array_length(__children) <= 0) return __localTop;
        
        var _value = __children[0].__localTop;
        var _i = 1;
        repeat(array_length(__children)-1)
        {
            _value = min(_value, __children[_i].__localTop);
            ++_i;
        }
        
        return _value;
    },
    function(_value)
    {
        __BentoError("Cannot set \"childMinTop\"");
    });
    
    VariableBind("childMaxRight", function()
    {
        if (array_length(__children) <= 0) return __localRight;
        
        var _value = __children[0].__localRight;
        var _i = 1;
        repeat(array_length(__children)-1)
        {
            _value = max(_value, __children[_i].__localRight);
            ++_i;
        }
        
        return _value;
    },
    function(_value)
    {
        __BentoError("Cannot set \"childMaxRight\"");
    });
    
    VariableBind("childMaxBottom", function()
    {
        if (array_length(__children) <= 0) return __localBottom;
        
        var _value = __children[0].__localBottom;
        var _i = 1;
        repeat(array_length(__children)-1)
        {
            _value = max(_value, __children[_i].__localBottom);
            ++_i;
        }
        
        return _value;
    },
    function(_value)
    {
        __BentoError("Cannot set \"childMaxBottom\"");
    });
    
    #endregion
}