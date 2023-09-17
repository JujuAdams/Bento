function __BentoClassLayer() constructor
{
    static _global       = __BentoGlobal();
    static _debugStruct  = _global.__debug;
    static _nullCallback = _global.__nullCallback;
    
    __name     = BentoRandomUUID();
    __host     = _global.__currentHost;
    __priority = undefined;
    behavior   = BENTO_BEHAVIOR_MODAL;
    
    __host.__LayerAddTop(self);
    
    __struct            = undefined;
    __volatile          = false;
    __volatileKeepAlive = true;
    
    __destroyed = false;
    
    __pointerX      = 0;
    __pointerY      = 0;
    __pointerStartX = 0;
    __pointerStartY = 0;
    
    __highlightRef     = undefined;
    __lastHighlightRef = undefined;
    
    __inputDirectionState = false;
    
    __captureRef        = undefined;
    __captureButtonName = undefined;
    __captureTime       = infinity;
    __captureLatch      = false;
    
    __stateButtonDict = {};
    
    __getter = {};
    __setter = {};
    
    if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Created ", self);
    
    
    
    
    
    VariableBind("name", function()
    {
        return __name;
    },
    function(_value)
    {
        if (_value != __name)
        {
            __host.__LayerDelete(_value);
            
            var _oldName = string(self);
            __name = _value;
            if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Renamed ", _oldName, " to ", self);
        }
    });
    
    VariableBind("volatile", function()
    {
        return __volatile;
    },
    function(_value)
    {
        if (_value && (not __volatile))
        {
            if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Layer \"", __name, "\" marked as volatile");
        }
        
        __volatile          = _value;
        __volatileKeepAlive = true;
    });
    
    VariableBind("priority", function()
    {
        return __priority;
    },
    function(_value)
    {
        if (__priority != _value) __host.__LayerMoveToPriority(self, _value);
    });
    
    
    
    
    
    static toString = function()
    {
        return "<layer " + __name + ">";
    }
    
    static VariableBind = function(_name, _getter, _setter)
    {
        __getter[$ _name] = (_getter == undefined)? _getter : method(undefined, _getter);
        __setter[$ _name] = (_setter == undefined)? _setter : method(undefined, _setter);
    }
    
    static Get = function(_name)
    {
        var _method = __getter[$ _name];
        if (is_method(_method))
        {
            return _method();
        }
        else
        {
            return self[$ _name];
        }
    }
    
    static Set = function(_name, _value)
    {
        var _method = __setter[$ _name];
        if (is_method(_method))
        {
            _method(_value);
        }
        else
        {
            self[$ _name] = _value;
        }
    }
    
    static __VolatileKeepAlive = function()
    {
        __volatileKeepAlive = true;
    }
    
    static MoveToTop = function()
    {
        __host.__LayerMoveToTop(self);
    }
    
    static MoveOver = function(_targetName)
    {
        __host.__LayerMoveOver(self, _targetName);
    }
    
    
    
    
    
    #region __BentoClassShared emulation functions
    
    __localLeft   = __host.__worldLeft;
    __localTop    = __host.__worldTop;
    __localRight  = __host.__worldRight;
    __localBottom = __host.__worldBottom;
    __localX      = 0.5*(__localLeft + __localRight);
    __localY      = 0.5*(__localTop + __localBottom);
    __localWidth  = __localRight - __localLeft;
    __localHeight = __localBottom - __localTop;
    
    __popLayerOnClose = true;
    
    
    
    VariableBind("left", function()
    {
        return __localLeft;
    },
    function(_value)
    {
        __BentoError("Cannot set \"width\" for layers");
    });
    
    VariableBind("top", function()
    {
        return __localTop;
    },
    function(_value)
    {
        __BentoError("Cannot set \"top\" for layers");
    });
    
    VariableBind("right", function()
    {
        return __localRight;
    },
    function(_value)
    {
        __BentoError("Cannot set \"right\" for layers");
    });
    
    VariableBind("bottom", function()
    {
        return __localBottom;
    },
    function(_value)
    {
        __BentoError("Cannot set \"bottom\" for layers");
    });
    
    VariableBind("x", function()
    {
        return __localX;
    },
    function(_value)
    {
        __BentoError("Cannot set \"x\" for layers");
    });
    
    VariableBind("y", function()
    {
        return __localY;
    },
    function(_value)
    {
        __BentoError("Cannot set \"y\" for layers");
    });
    
    VariableBind("width", function()
    {
        return __localWidth;
    },
    function(_value)
    {
        __BentoError("Cannot set \"width\" for layers");
    });
    
    VariableBind("height", function()
    {
        return __localHeight;
    },
    function(_value)
    {
        __BentoError("Cannot set \"height\" for layers");
    });
    
    
    
    static HasChildren = function()
    {
        return is_struct(__struct);
    }
    
    static __ChildAdd = function(_child)
    {
        return __ChildReplace(_child);
    }
    
    static __ChildGetIndex = function()
    {
        return undefined;
    }
    
    static __ChildReplace = function(_child, _index_UNUSED)
    {
        if (is_struct(__struct) && (__struct.__parent = self)) __struct.__parent = undefined;
        
        _child.__parent = self;
        __struct = _child;
    }
    
    static __ChildRemove = function(_child)
    {
        if (is_struct(_child) && (_child.__parent = self)) _child.__parent = undefined;
        if (_child == __struct) __struct = undefined;
    }
    
    static __FindLayer = function()
    {
        return self;
    }
    
    static __CallbackGet = function()
    {
        return _nullCallback;
    }
    
    static __LayoutExecute = function()
    {
        if (!is_struct(__struct)) return;
        return __struct.__LayoutExecute();
    }
    
    static __LayoutBuildOrder = function(_array)
    {
        if (!is_struct(__struct)) return;
        return __struct.__LayoutBuildOrder(_array);
    }
    
    static __FileOriginSearch = function(_filePathArray, _resultArray)
    {
        if (!is_struct(__struct)) return;
        __struct.__FileOriginSearch(_filePathArray, _resultArray);
        return _resultArray;
    }
    
    static __CaptureCastSearch = function()
    {
        return undefined;
    }
    
    static BuildIn = function()
    {
        if (!is_struct(__struct)) return;
        __struct.BuildIn();
    }
    
    #endregion
    
    
    
    
    
    static __InputProcess = function(_pointerMode, _pointerX, _pointerY, _retrigger, _threshold, _buttonArray)
    {
        static _result = {
            __struct:   undefined,
            __distance: undefined,
        }
        
        if (behavior >= BENTO_BEHAVIOR_PASSTHROUGH) //Don't pass input to anything with 0 behavior
        {
            __BentoLayerStackPush(self);
            
            switch(_pointerMode)
            {
                case BENTO_INPUT_MODE_POINTER:
                    __pointerX = _pointerX;
                    __pointerY = _pointerY;
                    __BentoTrace("Set layer \"", __name, "\" pointer as ", __pointerX, ",", __pointerY);
                break;
                
                case BENTO_INPUT_MODE_DIRECTIONAL:
                    if (is_struct(__struct))
                    {
                        var _distance = point_distance( 0, 0, _pointerX, _pointerY);
                        if (_distance < _threshold)
                        {
                            __inputDirectionState = false;
                        }
                        else if (_retrigger || (not __inputDirectionState))
                        {
                            __inputDirectionState = true;
                            
                            var _nX = _pointerX / _distance; 
                            var _nY = _pointerY / _distance;
                            
                            _result.__struct   = undefined;
                            _result.__distance = infinity;
                            
                            __struct.__HighlightableFreeSearch(__pointerX, __pointerY, _nX, _nY, __BentoNullableRefResolve(__highlightRef), -infinity, -infinity, infinity, infinity, _result);
                            
                            if (is_struct(_result.__struct))
                            {
                                with(_result.__struct)
                                {
                                    other.__pointerX = 0.5*(__worldLeft + __worldRight);
                                    other.__pointerY = 0.5*(__worldTop + __worldBottom);
                                }
                            }
                        }
                    }
                break;
                
                default:
                    __BentoError("Input pointer mode \"", _pointerMode, "\" for ", self, " not recognised");
                break;
            }
            
            if (is_struct(__struct))
            {
                __HighlightSet(__struct.__HighlightSearch(__pointerX, __pointerY, -infinity, -infinity, infinity, infinity));
            }
            
            var _j = 0;
            repeat(array_length(_buttonArray))
            {
                var _buttonData = _buttonArray[_j];
                switch(_buttonData.__type)
                {
                    case "click":
                        __InputProcessClick(_buttonData.__name, _buttonData.__state, _pointerMode);
                    break;
                    
                    case "cast":
                        __InputProcessCast(_buttonData.__name, _buttonData.__state, _pointerMode);
                    break;
                    
                    default:
                        __BentoError("Button mode \"", _buttonData.__type, "\" for button \"", _buttonData.__name, "\" for ", self, " not recognised");
                    break;
                }
                
                ++_j;
            }
            
            __BentoLayerStackPop();
        }
    }
    
    static __InputClearAll = function(_clearHighlight)
    {
        if (behavior >= BENTO_BEHAVIOR_PASSTHROUGH) //Don't pass input to anything with 0 behavior
        {
            __BentoLayerStackPush(self);
            
            //Clear the button dictionary entirely
            __stateButtonDict = {};
            
            //Execute the BUTTON_END callback for the captured button
            __BentoNullableRefCall(__captureRef, __BENTO_CALL.__BUTTON_END, __captureButtonName);
            
            //And then reset the rest of the capture state
            __CaptureSet(undefined, undefined, false);
            if (_clearHighlight) __HighlightSet(undefined);
            __BentoLayerStackPop();
        }
    }
    
    
    
    
    
    static __Close = function()
    {
        
    }
    
    static __Step = function()
    {
        if (is_struct(__struct))
        {
            __BentoLayerStackPush(self);
            __struct.__Step(__localLeft, __localTop, 1);
            __BentoLayerStackPop();
        }
        
        if (__volatile)
        {
            if (__volatileKeepAlive)
            {
                __volatileKeepAlive = false;
            }
            else
            {
                if (BENTO_REPORT_LEVEL > 1) __BentoTrace(self, " not kept alive, destroying");
                __destroyed = true;
            }
        }
    }
    
    static __Draw = function()
    {
        __BentoLayerStackPush(self);
        
        if (is_struct(__struct))
        {
            __struct.__Draw(__localLeft, __localTop, 1);
        }
        
        if (_debugStruct.__showPointer)
        {
            var _x = BentoPointerGetX();
            var _y = BentoPointerGetY();
            
            var _oldAlpha = draw_get_alpha();
            var _oldColor = draw_get_color();
            
            draw_set_color(c_white);
            draw_set_alpha(1);
            
            draw_circle(_x, _y, 15, true);
            draw_triangle(_x, _y, _x + 15, _y + 5, _x + 5, _y + 15, true);
            
            draw_text(_x, _y + 20, string_format(_x, 0, 0) + "," + string_format(_y, 0, 0));
            
            draw_set_color(_oldColor);
            draw_set_alpha(_oldAlpha);
        }
        
        __BentoLayerStackPop();
    }
    
    static __InputProcessClick = function(_buttonName, _state, _pointerMode)
    {
        var _buttonStateDict = __stateButtonDict;
        var _oldState = _buttonStateDict[$ _buttonName] ?? false;
        
        if (_state)
        {
            _buttonStateDict[$ _buttonName] = true;
        }
        else
        {
            variable_struct_remove(__stateButtonDict, _buttonName);
        }
        
        //Handle latching
        if (__BENTO_TEST_LATCHING || (_pointerMode == BENTO_INPUT_MODE_DIRECTIONAL))
        {
            var _captureStruct = __BentoNullableRefResolve(__captureRef);
            if (is_struct(_captureStruct) && _captureStruct.latch)
            {
                //Toggle on released (falling edge)
                if (_oldState && !_state) __captureLatch = !__captureLatch;
            }
            else
            {
                __captureLatch = false;
            }
            
            if (!_state && __captureLatch)
            {
                _state    = true;
                _oldState = true;
            }
        }
        
        if (_oldState != _state)
        {
            if (_state)
            {
                //Button pressed
                
                //Only allow new input if we're not clicking other buttons
                if (variable_struct_names_count(_buttonStateDict) == 1)
                {
                    __CaptureSet(__BentoNullableRefResolve(__highlightRef), _buttonName, false);
                }
            }
            else
            {
                //Button released
                
                var _highlightRef = __highlightRef;
                var _captureRef   = __captureRef;
                var _dragSuccess = false;
                
                if (__captureButtonName == _buttonName)
                {
                    var _click = false;
                    
                    if (__BentoNullableRefAlive(_highlightRef) && __BentoNullableRefAlive(_captureRef) && (__BentoNullableRefResolve(_highlightRef) == __BentoNullableRefResolve(_captureRef)))
                    {
                        _click = true;
                    }
                    
                    __CaptureSet(undefined, _buttonName, _click);
                }
            }
        }
        else if (_state)
        {
            //Button held
            
            if (__captureButtonName == _buttonName)
            {
                var _captureRef = __captureRef;
                if (__BentoNullableRefAlive(_captureRef))
                {
                    var _captureStruct = __BentoNullableRefResolve(_captureRef);
                    _captureStruct.__CallbackGet(__BENTO_CALL.__BUTTON).__Call(_captureStruct, _buttonName);
                }
            }
        }
    }
    
    static __InputProcessCast = function(_buttonName, _state, _pointerMode)
    {
        var _buttonStateDict = __stateButtonDict;
        var _oldState = _buttonStateDict[$ _buttonName] ?? false;
        
        if (_state)
        {
            _buttonStateDict[$ _buttonName] = true;
        }
        else
        {
            variable_struct_remove(__stateButtonDict, _buttonName);
        }
        
        //Handle latching
        if (__BENTO_TEST_LATCHING || (_pointerMode == BENTO_INPUT_MODE_DIRECTIONAL))
        {
            var _captureStruct = __BentoNullableRefResolve(__captureRef);
            if (is_struct(_captureStruct) && _captureStruct.latch)
            {
                //Toggle on released (falling edge)
                if (_oldState && !_state) __captureLatch = !__captureLatch;
            }
            else
            {
                __captureLatch = false;
            }
            
            _state = (_state || __captureLatch);
        }
        
        if (_oldState != _state)
        {
            if (_state)
            {
                //Button pressed
                
                //Only allow new input if we're not clicking other buttons
                if (variable_struct_names_count(_buttonStateDict) == 1)
                {
                    var _castFrom = __BentoNullableRefAlive(__lastHighlightRef)? __BentoNullableRefResolve(__lastHighlightRef) : __struct;
                    var _captureStruct = is_struct(_castFrom)? _castFrom.__CaptureCastSearch(_buttonName) : undefined;
                    
                    __CaptureSet(_captureStruct, _buttonName, false);
                }
            }
            else
            {
                //Button released
                
                if (__captureButtonName == _buttonName)
                {
                    __CaptureSet(undefined, _buttonName, true);
                }
            }
        }
        else if (_state)
        {
            //Button held
            
            if (__captureButtonName == _buttonName)
            {
                var _captureRef = __captureRef;
                if (__BentoNullableRefAlive(_captureRef))
                {
                    var _captureStruct = __BentoNullableRefResolve(_captureRef);
                    _captureStruct.__CallbackGet(__BENTO_CALL.__BUTTON).__Call(_captureStruct, _buttonName);
                }
            }
        }
    }
    
    
    
    
    
    static __HighlightFirst = function()
    {
        if (!is_struct(__struct)) return;
        if (__BentoNullableRefAlive(__highlightRef)) return;
        
        var _highlightStruct = __struct.__HighlightableSearchFirst();
        if (_highlightStruct == undefined) return;
        
        with(_highlightStruct)
        {
            other.__pointerX = 0.5*(__worldLeft + __worldRight);
            other.__pointerY = 0.5*(__worldTop + __worldBottom);
        }
        
        __HighlightSet(_highlightStruct);
    }
    
    static __HighlightSet = function(_newStruct)
    {
        var _oldStruct = __BentoNullableRefResolve(__highlightRef);
        if (_oldStruct != _newStruct)
        {
            if (_oldStruct != undefined)
            {
                if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Unsetting highlight ", _oldStruct);
                _oldStruct.__CallbackGet(__BENTO_CALL.__HIGHLIGHT_END).__Call(_oldStruct);
                __highlightRef = undefined;
            }
            
            if (_newStruct != undefined)
            {
                if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Setting highlight ", _newStruct);
                _newStruct.__CallbackGet(__BENTO_CALL.__HIGHLIGHT_START).__Call(_newStruct);
                __highlightRef     = __BentoNullableRefCreate(_newStruct);
                __lastHighlightRef = __highlightRef;
            }
        }
        else
        {
            if (_oldStruct != undefined) _oldStruct.__CallbackGet(__BENTO_CALL.__HIGHLIGHT).__Call(_oldStruct);
        }
    }
    
    static __CaptureSet = function(_newStruct, _buttonName, _click)
    {
        var _oldStruct = __BentoNullableRefResolve(__captureRef);
        if (_oldStruct != _newStruct)
        {
            if (_oldStruct != undefined)
            {
                _oldStruct.__CallbackGet(__BENTO_CALL.__BUTTON_END).__Call(_oldStruct, __captureButtonName);
                if (_click) __BentoInputButtonClick(_oldStruct, __captureButtonName);
                
                __captureRef        = undefined;
                __captureButtonName = undefined;
                __captureTime       = infinity;
                __pointerStartX     = undefined;
                __pointerStartY     = undefined;
            }
            
            if (_newStruct != undefined)
            {
                __captureRef        = __BentoNullableRefCreate(_newStruct);
                __captureButtonName = _buttonName;
                __captureTime       = current_time;
                __pointerStartX     = __pointerX;
                __pointerStartY     = __pointerY;
                
                _newStruct.__CallbackGet(__BENTO_CALL.__BUTTON_START).__Call(_newStruct, _buttonName);
            }
        }
    }
}