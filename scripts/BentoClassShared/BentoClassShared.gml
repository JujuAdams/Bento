/// @param typeOverride

function BentoClassShared(_typeOverride = instanceof(self)) constructor
{
    static _global       = __BentoGlobal();
    static _debugStruct  = _global.__debug;
    static _nullCallback = _global.__nullCallback;
    
    __popLayerOnClose = false;
    __type = _typeOverride;
    
    
    
    
    
    /// Public variables ///
    identifier     = undefined; //Assigned below
    highlightGroup = undefined;
    latch          = false;
    layoutInclude  = true;
    navigationLock = false;
    ////////////////////////
    
    
    
    
    
    if (_global.__createReplaceTarget == undefined)
    {
        //Our parent is whatever is on top of the stack
        var _parent = __BentoContextStackTop();
        if (instanceof(_parent) == "__BentoClassLayer")
        {
            __address = "";
        }
        else
        {
            __address = _parent.identifier + "[" + string(array_length(_parent.__children)) + "] -> ";
        }
        
        _parent.__ChildAdd(self);
        identifier = __address + __type;
    }
    else
    {
        var _target = _global.__createReplaceTarget;
        _global.__createReplaceTarget = undefined;
        
        var _parent = _target.__parent;
        if (_parent == undefined)
        {
            __BentoError("Target \"", _target, "\" has no parent");
        }
        
        var _index = _parent.__ChildGetIndex(_target);
        if (instanceof(_parent) == "__BentoClassLayer")
        {
            __address = "";
        }
        else
        {
            if (_index == undefined) __BentoError("Cannot find \"", _target, "\" on alleged parent \"", _parent, "\"");
            __address = _parent.identifier + "[" + string(_index) + "] -> ";
        }
        
        _parent.__ChildReplace(self, _index);
        identifier = _target.identifier; //Copy the identifier too
    }
    
    
    
    
    
    __animMode      = BENTO_BUILD_FINISHED;
    __animTime      = 0;
    animXOffset     = 0;
    animYOffset     = 0;
    animScale       = 1;
    animAlpha       = 1;
    animBlend       = c_white;
    animBlendAmount = 0;
    
    buildInLength = BENTO_DEFAULT_BUILD_IN_LENGTH;
    
    __children   = [];
    __fileOrigin = undefined;
    
    __callbackArray = array_create(__BENTO_CALL.__SIZE);
    var _i = 0;
    repeat(array_length(__callbackArray))
    {
        __callbackArray[@ _i] = [undefined];
        ++_i;
    }
    
    __listenTargetDict  = {};
    __listenTargetArray = [];
    __listenCastDict    = {};
    __listenCastArray   = [];
    
    __getter = {};
    __setter = {};
    
    __captureClipChildren = false;
    
    __originX = 0.5; //Normalized value
    __originY = 0.5; //Normalized value
    
    __originXStashed = undefined;
    __originYStashed = undefined;
    
    //Nullable weak references
    __navigationRight = undefined;
    __navigationUp    = undefined;
    __navigationLeft  = undefined;
    __navigationDown  = undefined;
    
    __localScale  = 1;
    __localLeft   = 0;
    __localTop    = 0;
    __localRight  = 0;
    __localBottom = 0;
    __localX      = 0;
    __localY      = 0;
    __localWidth  = 0;
    __localHeight = 0;
    
    __worldOffsetX = 0;
    __worldOffsetY = 0;
    __worldScale   = 1;
    __worldLeft    = 0;
    __worldTop     = 0;
    __worldRight   = 0;
    __worldBottom  = 0;
    
    __drawOffsetX = 0;
    __drawOffsetY = 0;
    __drawScale   = 1;
    __drawLeft    = 0;
    __drawTop     = 0;
    __drawRight   = 0;
    __drawBottom  = 0;
    
    __active  = true;
    __visible = true;
    
    __stateHighlight  = false;
    __stateFocus      = false;
    __stateButtonDict = {};
    
    
    
    
    
    #region Public Methods
    
    static toString = function()
    {
        return identifier;
    }
    
    static GetIdentifier = function()
    {
        return identifier;
    }
    
    static SetIdentifier = function(_value)
    {
        identifier = string(_value);
        
        return self;
    }
    
    static GetType = function()
    {
        return __type;
    }
    
    static GetUUID = function()
    {
        return __address;
    }
    
    static GetHighlight = function()
    {
        return __stateHighlight;
    }
    
    static GetFocus = function()
    {
        return __stateFocus;
    }
    
    static GetButton = function(_name)
    {
        if (_name == undefined) return (variable_struct_names_count(__stateButtonDict) > 0);
        return __stateButtonDict[$ _name] ?? false;
    }
    
    static HasChildren = function()
    {
        return (array_length(__children) > 0);
    }
    
    static Find = function(_id)
    {
        if (identifier == _id) return self;
        
        var _i = 0;
        repeat(array_length(__children))
        {
            var _found = __children[_i].Find(_id);
            if (_found != undefined) return _found;
            ++_i;
        }
        
        return undefined;
    }
    
    static HighlightStateSet = function(_state)
    {
        __stateHighlight = _state;
        
        return self;
    }
    
    static ButtonStateSet = function(_name, _state)
    {
        if (_state)
        {
            __stateButtonDict[$ _name] = true;
        }
        else
        {
            variable_struct_remove(__stateButtonDict, _name);
        }
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
    
    static ReplaceFromFile = function(_file)
    {
        if (BENTO_REPORT_LEVEL > 0) __BentoTrace("Reloading \"", self, "\" (file = \"", _file, "\")");
        
        var _oldCreateTarget = _global.__createReplaceTarget;
        _global.__createReplaceTarget = self;
        __BentoFileEnsure(_file).__Execute();
        _global.__createReplaceTarget = _oldCreateTarget;
    }
    
    static __FindLayer = function()
    {
        return __parent.__FindLayer();
    }
    
    #endregion
    
    
    
    
    
    #region Build Animations
    
    VariableBind("callbackBuildIn", function()
    {
        __BentoError("Cannot get \"callbackBuildIn\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__BUILD_IN, _value);
    });
    
    static BuildIn = function()
    {
        if (__CallbackExists(__BENTO_CALL.__BUILD_IN))
        {
            __animMode = BENTO_BUILD_IN;
            __animTime = 0;
            __CallbackGet(__BENTO_CALL.__BUILD_IN).__Call(self, __animTime);
        }
        
        var _i = 0;
        repeat(array_length(__children))
        {
            __children[_i].BuildIn();
            ++_i;
        }
    }
    
    static BuildFinish = function()
    {
        __animMode = BENTO_BUILD_FINISHED;
    }
    
    static GetBuilding = function()
    {
        return __animMode;
    }
    
    #endregion
    
    
    
    
    
    #region Callback Setters
    
    static __CallbackSet = function(_callType, _function)
    {
        var _targetArray = __callbackArray[_callType];
        
        var _callback = new __BentoClassCallback(_targetArray[0], _function, false);
        array_insert(_targetArray, 0, _callback);
        
        return self;
    }
    
    
    
    static CallbackSetHighlightStart = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__HIGHLIGHT_START, _function);
    }
    
    static CallbackSetHighlight = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__HIGHLIGHT, _function);
    }
    
    static CallbackSetHighlightEnd = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__HIGHLIGHT_END, _function);
    }
    
    
    
    static CallbackSetButtonStart = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__BUTTON_START, _function);
    }
    
    static CallbackSetButton = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__BUTTON, _function);
    }
    
    static CallbackSetButtonEnd = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__BUTTON_END, _function);
    }
    
    static CallbackSetButtonClick = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__BUTTON_CLICK, _function);
    }
    
    static CallbackSetButtonCanCapture = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__BUTTON_CAN_CAPTURE, _function);
    }
    
    
    
    static CallbackSetStep = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__STEP, _function);
    }
    
    static CallbackSetDraw = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__DRAW, _function);
    }
    
    static CallbackSetOnClose = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__ON_CLOSE, _function);
    }
    
    static CallbackSetCanHighlight = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__CAN_HIGHLIGHT, _function);
    }
    
    
    
    static CallbackSetLayoutExecute = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__LAYOUT_EXECUTE, _function);
    }
    
    static CallbackSetLayoutCheck = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__LAYOUT_CHECK, _function);
    }
    
    
    
    static CallbackSetOnValueChange = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__ON_VALUE_CHANGE, _function);
    }
    
    static CallbackSetValueUpdate = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__VALUE_UPDATE, _function);
    }
    
    static CallbackSetBuildIn = function(_function)
    {
        return __CallbackSet(__BENTO_CALL.__BUILD_IN, _function);
    }
    
    #endregion
    
    
    
    
    
    #region Child-related Methods
    
    static __ChildAdd = function(_child)
    {
        _child.__parent = self;
        array_push(__children, _child);
    }
    
    static __ChildReplace = function(_child, _index)
    {
        _child.__parent = self;
        __children[@ _index] = _child;
    }
    
    static __ChildGetIndex = function(_target)
    {
        return __BentoArrayFindIndex(__children, _target);
    }
    
    static __ChildRemove = function(_child)
    {
        var _i = 0;
        repeat(array_length(__children))
        {
            if (__children[_i] == _child)
            {
                array_delete(__children, _i, 1);
            }
            else
            {
                ++_i;
            }
        }
    }
    
    static __ParentChange = function(_newParent)
    {
        if (__parent != undefined) __parent.__ChildRemove(self);
        if (_newParent != undefined) _newParent.__ChildAdd(self);
    }
    
    static __PercentageWidth = function(_value)
    {
        if (is_numeric(_value)) return _value;
        
        if (is_string(_value))
        {
            if (string_char_at(_value, string_length(_value)) == "%")
            {
                try
                {
                    var _percentage = real(string_copy(_value, 1, string_length(_value)-1))
                }
                catch(_error)
                {
                    __BentoError("Failed to parse percentage string \"", _value, "\"");
                }
                
                return __parent.__localWidth * _percentage/100;
            }
        }
        
        __BentoError("Invalid parameter for x-axis \"", _value, "\"");
    }
    
    static __PercentageHeight = function(_value)
    {
        if (is_numeric(_value)) return _value;
        
        if (is_string(_value))
        {
            if (string_char_at(_value, string_length(_value)) == "%")
            {
                try
                {
                    var _percentage = real(string_copy(_value, 1, string_length(_value)-1))
                }
                catch(_error)
                {
                    __BentoError("Failed to parse percentage string \"", _value, "\"");
                }
                
                return __parent.__localHeight * _percentage/100;
            }
        }
        
        __BentoError("Invalid parameter for y-axis \"", _value, "\"");
    }
    
    #endregion
    
    
    
    
    
    #region Other Private Methods
    
    static __ScrollParentToSelf = function()
    {
        __parent.__ScrollTo(self);
    }
    
    static __ScrollTo = function(_target)
    {
        //If we're not a scroll box, pass through the command to our parent
        __ScrollParentToSelf();
    }
    
    static __Close = function()
    {
        __CallbackGet(__BENTO_CALL.__ON_CLOSE).__Call(self);
    }
    
    static __Step = function(_offsetX, _offsetY, _inheritedScale, _executeCallback)
    {
        __BentoContextStackPush(self);
        
        if (_executeCallback && (__animMode == BENTO_BUILD_IN))
        {
            ++__animTime;
            __CallbackGet(__BENTO_CALL.__BUILD_IN).__Call(self, __animTime);
            if (__animTime >= buildInLength) BuildFinish();
        }
        
        _offsetX += animXOffset;
        _offsetY += animYOffset;
        
        __worldScale   = __localScale;
        __worldOffsetX = _offsetX;
        __worldOffsetY = _offsetY;
        __worldLeft    = _offsetX + __worldScale*(_inheritedScale*__localLeft   - __localX) + __localX;
        __worldTop     = _offsetY + __worldScale*(_inheritedScale*__localTop    - __localY) + __localY;
        __worldRight   = _offsetX + __worldScale*(_inheritedScale*__localRight  - __localX) + __localX;
        __worldBottom  = _offsetY + __worldScale*(_inheritedScale*__localBottom - __localY) + __localY;
        __worldScale  *= _inheritedScale;
        
        if (_executeCallback && __active) __CallbackGet(__BENTO_CALL.__STEP).__Call(self);
        
        var _i = 0;
        repeat(array_length(__children))
        {
            __children[_i].__Step(__worldLeft, __worldTop, __worldScale, _executeCallback);
            ++_i;
        }
        
        __BentoContextStackPop();
    }
    
    static __Draw = function(_offsetX, _offsetY, _inheritedScale)
    {
        __BentoContextStackPush(self);
        
        _offsetX += animXOffset;
        _offsetY += animYOffset;
        
        __drawScale   = __localScale*animScale;
        __drawOffsetX = _offsetX;
        __drawOffsetY = _offsetY;
        __drawLeft    = _offsetX + __drawScale*(_inheritedScale*__localLeft   - __localX) + __localX;
        __drawTop     = _offsetY + __drawScale*(_inheritedScale*__localTop    - __localY) + __localY;
        __drawRight   = _offsetX + __drawScale*(_inheritedScale*__localRight  - __localX) + __localX;
        __drawBottom  = _offsetY + __drawScale*(_inheritedScale*__localBottom - __localY) + __localY;
        __drawScale  *= _inheritedScale;
        
        if (_debugStruct.__showSkeleton)
        {
            var _oldColor = draw_get_color();
            var _oldAlpha = draw_get_alpha();
            draw_set_color(c_white);
            draw_set_alpha(1);
            
            draw_rectangle(__drawLeft, __drawTop, __drawRight, __drawBottom, true);
            
            draw_set_color(_oldColor);
            draw_set_alpha(_oldAlpha);
        }
        
        if (__visible)
        {
            __CallbackGet(__BENTO_CALL.__DRAW).__Call(self);
        }
        
        var _i = 0;
        repeat(array_length(__children))
        {
            __children[_i].__Draw(__drawLeft, __drawTop, __drawScale);
            ++_i;
        }
        
        __BentoContextStackPop();
    }
    
    
    
    
    
    static __CallbackSetFromBentoScript = function(_callType, _function)
    {
        var _targetArray = __callbackArray[_callType];
        
        var _callback = new __BentoClassCallback(_targetArray[0], _function, true);
        array_insert(_targetArray, 0, _callback);
        
        return self;
    }
    
    static __CallbackExists = function(_callType)
    {
        return (array_length(__callbackArray[_callType]) > 1);
    }
    
    static __CallbackCategoryExists = function(_callType)
    {
        switch(_callType)
        {
            case __BENTO_CALL.__HIGHLIGHT_START:
            case __BENTO_CALL.__HIGHLIGHT:
            case __BENTO_CALL.__HIGHLIGHT_END:
            case __BENTO_CALL.__CATEGORY_HIGHLIGHT:
                return __CallbackExists(__BENTO_CALL.__HIGHLIGHT_START)
                    || __CallbackExists(__BENTO_CALL.__HIGHLIGHT)
                    || __CallbackExists(__BENTO_CALL.__HIGHLIGHT_END);
            break;
            
            case __BENTO_CALL.__BUTTON_START:
            case __BENTO_CALL.__BUTTON:
            case __BENTO_CALL.__BUTTON_END:
            case __BENTO_CALL.__BUTTON_CLICK:
            case __BENTO_CALL.__BUTTON_CAN_CAPTURE:
            case __BENTO_CALL.__CATEGORY_BUTTON:
                return __CallbackExists(__BENTO_CALL.__BUTTON_START)
                    || __CallbackExists(__BENTO_CALL.__BUTTON)
                    || __CallbackExists(__BENTO_CALL.__BUTTON_END)
                    || __CallbackExists(__BENTO_CALL.__BUTTON_CLICK)
                    || __CallbackExists(__BENTO_CALL.__BUTTON_CAN_CAPTURE);
            break;
            
            case __BENTO_CALL.__STEP:
                return __CallbackExists(__BENTO_CALL.__STEP);
            break;
            
            case __BENTO_CALL.__DRAW:
                return __CallbackExists(__BENTO_CALL.__DRAW);
            break;
            
            case __BENTO_CALL.__CATEGORY_ANY_INTERACTION:
                return __CallbackCategoryExists(__BENTO_CALL.__CATEGORY_HIGHLIGHT)
                    || __CallbackCategoryExists(__BENTO_CALL.__CATEGORY_BUTTON);
            break;
            
            default:
                __BentoError("Unhandled call type ", _callType);
            break;
        }
    }
    
    static __CallbackGet = function(_callType)
    {
        return __callbackArray[_callType][0] ?? _nullCallback;
    }
    
    
    
    
    
    static __FindCaptureCast = function(_buttonName)
    {
        if (__active && (__animMode == BENTO_BUILD_FINISHED) && __CanRespondToButtonCast(_buttonName))
        {
            return self;
        }
        
        var _i = 0;
        repeat(array_length(__children))
        {
            var _captureStruct = __children[_i].__FindCaptureCast(_buttonName);
            if (_captureStruct != undefined) return _captureStruct;
            
            ++_i;
        }
        
        return undefined;
    }
    
    static __CanRespondToButtonTarget = function(_buttonName)
    {
        if (not (__listenTargetDict[$ _buttonName] ?? false)) return false;
        
        if (not __CallbackExists(__BENTO_CALL.__BUTTON_CAN_CAPTURE)) return true;
        
        return __CallbackGet(__BENTO_CALL.__BUTTON_CAN_CAPTURE).__Call(self, _buttonName);
    }
    
    static __CanRespondToButtonCast = function(_buttonName)
    {
        if (not (__listenCastDict[$ _buttonName] ?? false)) return false;
        
        if (not __CallbackExists(__BENTO_CALL.__BUTTON_CAN_CAPTURE)) return true;
        
        return __CallbackGet(__BENTO_CALL.__BUTTON_CAN_CAPTURE).__Call(self, _buttonName);
    }
    
    static __CanCaptureClickAnyEver = function() //TODO - Reimplement in a more effient way
    {
        if (array_length(__listenTargetArray) <= 0) return false;
        
        return __CallbackCategoryExists(__BENTO_CALL.__CATEGORY_BUTTON);
    }
    
    static __CanCaptureAnyEver = function() //TODO - Reimplement in a more effient way
    {
        if ((array_length(__listenTargetArray) <= 0)
        &&  (array_length(__listenCastArray ) <= 0))
        {
            return false;
        }
        
        return __CallbackCategoryExists(__BENTO_CALL.__CATEGORY_BUTTON);
    }
    
    static __CanCaptureClickAnyNow = function() //TODO - Reimplement in a more effient way
    {
        //If we haven't registered any captures, return <false>
        var _length = array_length(__listenTargetArray);
        if (_length <= 0) return false;
        
        //If there are no button callbacks then return <false>
        if (not __CallbackCategoryExists(__BENTO_CALL.__CATEGORY_BUTTON)) return false;
        
        //If we don't have a "can capture" callback then every named button can be captured
        if (not __CallbackCategoryExists(__BENTO_CALL.__BUTTON_CAN_CAPTURE)) return true;
        
        //Finally, check each named button to see if it can currently capture
        var _canCaptureCallback = __CallbackGet(__BENTO_CALL.__BUTTON_CAN_CAPTURE);
        var _i = 0;
        repeat(_length)
        {
            if (_canCaptureCallback(__listenTargetArray[_i])) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __CanHighlight = function()
    {
        if (not __CallbackCategoryExists(__BENTO_CALL.__CATEGORY_HIGHLIGHT)) return false;
        
        if (not __CallbackExists(__BENTO_CALL.__CAN_HIGHLIGHT)) return true;
        
        return __CallbackGet(__BENTO_CALL.__CAN_HIGHLIGHT).__Call(self);
    }
    
    #endregion
    
    
    
    
    
    #region Local Position Variable Bindings
    
    static TempOriginX = function(_value)
    {
        if (__originXStashed == undefined) __originXStashed = __originX;
        __originX = _value;
    }
    
    static TempOriginY = function(_value)
    {
        if (__originYStashed == undefined) __originYStashed = __originY;
        __originY = _value;
    }
    
    static TempOriginXReset = function()
    {
        if (__originXStashed != undefined)
        {
            __originX = __originXStashed;
            __originXStashed = undefined;
        }
    }
    
    static TempOriginYReset = function()
    {
        if (__originYStashed != undefined)
        {
            __originY = __originYStashed;
            __originYStashed = undefined;
        }
    }
    
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
            with(__FindLayer())
            {
                if (__BentoNullableRefResolve(__highlightRef) == other) __HighlightSet(undefined, false);
                if (__BentoNullableRefResolve(__captureRef  ) == other) __CaptureSet(undefined, undefined, false);
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
            with(__FindLayer())
            {
                if (__BentoNullableRefResolve(__highlightRef) == other) __HighlightSet(undefined, false);
                if (__BentoNullableRefResolve(__captureRef  ) == other) __CaptureSet(undefined, undefined, false);
            }
        }
    });
    
    #endregion
    
    
    
    
    
    #region Callback Getter/Setters
    
    VariableBind("callbackPress", function()
    {
        __BentoError("Cannot get \"callbackPress\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__BUTTON_START, _value);
    });
    
    VariableBind("callbackHold", function()
    {
        __BentoError("Cannot get \"callbackHold\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__BUTTON, _value);
    });
    
    VariableBind("callbackRelease", function()
    {
        __BentoError("Cannot get \"callbackRelease\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__BUTTON_END, _value);
    });
    
    VariableBind("callbackClick", function()
    {
        __BentoError("Cannot get \"callbackClick\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__BUTTON_CLICK, _value);
    });
    
    VariableBind("callbackCanCapture", function()
    {
        __BentoError("Cannot get \"callbackCanCapture\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__BUTTON_CAN_CAPTURE, _value);
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
    
    
    
    VariableBind("callbackEnter", function()
    {
        __BentoError("Cannot get \"callbackEnter\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__HIGHLIGHT_START, _value);
    });
    
    VariableBind("callbackOver", function()
    {
        __BentoError("Cannot get \"callbackOver\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__HIGHLIGHT, _value);
    });
    
    VariableBind("callbackLeave", function()
    {
        __BentoError("Cannot get \"callbackLeave\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__HIGHLIGHT_END, _value);
    });
    
    
    
    VariableBind("callbackStep", function()
    {
        __BentoError("Cannot get \"callbackStep\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__STEP, _value);
    });
    
    VariableBind("callbackDraw", function()
    {
        __BentoError("Cannot get \"callbackDraw\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__DRAW, _value);
    });
    
    
    
    VariableBind("callbackCanHighlight", function()
    {
        __BentoError("Cannot get \"callbackCanHighlight\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__CAN_HIGHLIGHT, _value);
    });
    
    VariableBind("callbackOnClose", function()
    {
        __BentoError("Cannot get \"callbackOnClose\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__ON_CLOSE, _value);
    });
    
    #endregion
    
    
    
    
    
    #region Layouts
    
    static __LayoutBuildOrder = function(_array)
    {
        if (__CallbackExists(__BENTO_CALL.__LAYOUT_EXECUTE) || __CallbackExists(__BENTO_CALL.__LAYOUT_CHECK))
        {
            array_push(_array, self);
        }
        
        var _i = 0;
        repeat(array_length(__children))
        {
            __children[_i].__LayoutBuildOrder(_array);
            ++_i;
        }
    }
    
    static __LayoutExecute = function()
    {
        return __CallbackGet(__BENTO_CALL.__LAYOUT_EXECUTE).__Call(self);
    }
    
    static __LayoutCheck = function()
    {
        return __CallbackGet(__BENTO_CALL.__LAYOUT_CHECK).__Call(self);
    }
    
    VariableBind("callbackLayout", function()
    {
        __BentoError("Cannot get \"callbackLayout\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__LAYOUT_EXECUTE, _value);
    });
    
    VariableBind("callbackLayoutCheck", function()
    {
        __BentoError("Cannot get \"callbackLayoutCheck\"");
        return;
    },
    function(_value)
    {
        __CallbackSetFromBentoScript(__BENTO_CALL.__LAYOUT_CHECK, _value);
    });
    
    #endregion
    
    
    
    
    
    #region Layout Vertical List
    
    static LayoutAsVerticalList = function(_hAlign, _spacing)
    {
        __layout = {
            __type:      "vertical list",
            __alignment: _hAlign,
            __spacing:   _spacing,
        };
        
        CallbackSetLayoutExecute(function()
        {
            var _y = 0;
            var _spacing = __layout.__spacing;
            
            switch(__layout.__alignment)
            {
                case "left":
                    var _i = 0;
                    repeat(array_length(__children))
                    {
                        var _child = __children[_i];
                        if (_child.layoutInclude)
                        {
                            TempOriginX(0);
                            TempOriginY(0);
                            _child.Set("x", 0);
                            _child.Set("y", _y);
                                
                            _y += _child.__localHeight + _spacing;
                        }
                            
                        ++_i;
                    }
                break;
                
                case "center":
                    var _x = 0.5*__localWidth;
                    
                    var _i = 0;
                    repeat(array_length(__children))
                    {
                        var _child = __children[_i];
                        if (_child.layoutInclude)
                        {
                            TempOriginX(0.5);
                            TempOriginY(0);
                            _child.Set("x", _x);
                            _child.Set("y", _y);
                                
                            _y += _child.__localHeight + _spacing;
                        }
                            
                        ++_i;
                    }
                break;
                
                case "right":
                    var _x = __localWidth;
                    
                    var _i = 0;
                    repeat(array_length(__children))
                    {
                        var _child = __children[_i];
                        if (_child.layoutInclude)
                        {
                            TempOriginX(1);
                            TempOriginY(0);
                            _child.Set("x", _x);
                            _child.Set("y", _y);
                                
                            _y += _child.__localHeight + _spacing;
                        }
                            
                        ++_i;
                    }
                break;
                
                default:
                    __BentoError("Unknown vertical list alignment \"", __layout.__alignment, "\"");
                break;
            }
        });
        
        CallbackSetLayoutCheck(function()
        {
            //Don't bother! Presume everything went according to plan
            return false;
        });
    }
    
    #endregion
    
    #region Layout Horizontal List
    
    static LayoutAsHorizontalList = function(_vAlign, _spacing)
    {
        __layout = {
            __type:      "horizontal list",
            __alignment: _vAlign,
            __spacing:   _spacing,
        };
        
        CallbackSetLayoutExecute(function()
        {
            var _x = 0;
            var _spacing = __layout.__spacing;
            
            switch(__layout.__alignment)
            {
                case "top":
                    var _i = 0;
                    repeat(array_length(__children))
                    {
                        with(__children[_i])
                        {
                            if (layoutInclude)
                            {
                                TempOriginX(0);
                                TempOriginY(0);
                                Set("x", _x);
                                Set("y", 0);
                                
                                _x += __localWidth + _spacing;
                            }
                        }
                        
                        ++_i;
                    }
                break;
                
                case "middle":
                    var _y = 0.5*__localWidth;
                    
                    var _i = 0;
                    repeat(array_length(__children))
                    {
                        with(__children[_i])
                        {
                            if (layoutInclude)
                            {
                                TempOriginX(0);
                                TempOriginY(0.5);
                                Set("x", _x);
                                Set("y", 0);
                                
                                _x += __localWidth + _spacing;
                            }
                        }
                        
                        ++_i;
                    }
                break;
                
                case "bottom":
                    var _y = __localHeight;
                    
                    var _i = 0;
                    repeat(array_length(__children))
                    {
                        with(__children[_i])
                        {
                            if (layoutInclude)
                            {
                                TempOriginX(0);
                                TempOriginY(1);
                                Set("x", 0);
                                Set("y", _y);
                                
                                _x += __localWidth + _spacing;
                            }
                        }
                        
                        ++_i;
                    }
                break;
                
                default:
                    __BentoError("Unknown vertical list alignment \"", __alignment, "\"");
                break;
            }
        });
        
        CallbackSetLayoutCheck(function()
        {
            //Don't bother! Presume everything went according to plan
            return false;
        });
    }
    
    #endregion
    
    #region Layout Grid
    
    static LayoutAsGrid = function(_cellWidth, _cellHeight)
    {
        __layout = {
            __type:       "grid",
            __cellWidth:  _cellWidth,
            __cellHeight: _cellHeight,
        };
        
        CallbackSetLayoutExecute(function()
        {
            var _maxWidth   = __localWidth;
            var _cellWidth  = __layout.__cellWidth;
            var _cellHeight = __layout.__cellHeight;
            
            var _x = _cellWidth/2;
            var _y = _cellHeight/2;
            
            var _i = 0;
            repeat(array_length(__children))
            {
                with(__children[_i])
                {
                    if (layoutInclude)
                    {
                        TempOriginX(0.5);
                        TempOriginY(0.5);
                        Set("x", _x);
                        Set("y", _y);
                        
                        _x += _cellWidth;
                        
                        if (_x > _maxWidth)
                        {
                            _x = _cellWidth/2;
                            _y += _cellHeight;
                        }
                    }
                }
                
                ++_i;
            }
        });
        
        CallbackSetLayoutCheck(function()
        {
            //Don't bother! Presume everything went according to plan
            return false;
        });
    }
    
    #endregion
    
    #region Layout Columns
    
    static LayoutAsColumns = function(_hAlign, _spacing, _inWidthArray)
    {
        //Make a copy of the array to avoid any static reference bizareness
        var _columnCount = array_length(_inWidthArray);
        var _widthArray = array_create(_columnCount, undefined);
        var _i = 0;
        repeat(_columnCount)
        {
            _widthArray[@ _i] = __PercentageWidth(_inWidthArray[_i]);
            ++_i;
        }
        
        __layout = {
            __type:         "columns",
            __alignment:    _hAlign,
            __spacing:      _spacing,
            __columnWidths: _widthArray,
        };
        
        CallbackSetLayoutExecute(function()
        {
            var _funcCenterElements = function(_i, _count, _y)
            {
                repeat(_count)
                {
                    with(__children[_i])
                    {
                        if (layoutInclude)
                        {
                            TempOriginY(0.5);
                            Set("y", _y);
                        }
                    }
                    
                    ++_i;
                }
            }
            
            var _hAlign      = __layout.__alignment;
            var _spacing     = __layout.__spacing;
            var _widthArray  = __layout.__columnWidths;
            var _columnCount = array_length(_widthArray);
            
            var _lineStart = 0;
            var _maxHeight = 0;
            
            var _x = 0;
            var _y = 0;
            
            var _lineCells = 0;
            var _i = 0;
            repeat(array_length(__children))
            {
                with(__children[_i])
                { 
                    if (layoutInclude)
                    {
                        var _columnWidth = _widthArray[_lineCells];
                        
                        switch(_hAlign)
                        {
                            case "left":
                                TempOriginX(0);
                                Set("x", _x);
                            break;
                            
                            case "center":
                                TempOriginX(0.5);
                                Set("x", _x + _columnWidth/2);
                            break;
                            
                            case "right":
                                TempOriginX(1);
                                Set("x", _x + _columnWidth);
                            break;
                            
                            default:
                                __BentoError("Unknown horizontal alignment \"", _hAlign, "\"");
                            break;
                        }
                        
                        _x += _columnWidth;
                        
                        _maxHeight = max(_maxHeight, Get("height"));
                        
                        ++_lineCells;
                        if (_lineCells >= _columnCount)
                        {
                            _funcCenterElements(_lineStart, _lineCells, _y + _maxHeight/2);
                            
                            _lineStart = _i+1;
                            _lineCells = 0;
                            
                            _x = 0;
                            _y += _maxHeight + _spacing;
                            _maxHeight = 0;
                        }
                    }
                }
                
                ++_i;
            }
            
            //Clean up any dangling children
            if (_lineCells > 0)
            {
                _funcCenterElements(_lineStart, _lineCells, _y + _maxHeight/2);
            }
        });
        
        CallbackSetLayoutCheck(function()
        {
            //Don't bother! Presume everything went according to plan
            return false;
        });
    }
    
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
    
    
    
    
    
    #region Search Methods
    
    static __FileOriginSearch = function(_filePathArray, _resultArray)
    {
        if (__BentoArrayFindIndex(_filePathArray, __fileOrigin) != undefined)
        {
            array_push(_resultArray, self);
            return _resultArray;
        }
        
        var _i = 0;
        repeat(array_length(__children))
        {
            __children[_i].__FileOriginSearch(_filePathArray, _resultArray);
            ++_i;
        }
        
        return _resultArray;
    }
    
    static __HighlightSearch = function(_pX, _pY, _limitLeft, _limitTop, _limitRight, _limitBottom)
    {
        __BentoContextStackPush(self);
        
        var _highlightStruct = undefined;
        
        var _visibleLeft   = __worldLeft;   //max(_limitLeft,   __worldLeft  );
        var _visibleTop    = __worldTop;    //max(_limitTop,    __worldTop   );
        var _visibleRight  = __worldRight;  //min(_limitRight,  __worldRight );
        var _visibleBottom = __worldBottom; //min(_limitBottom, __worldBottom);
        
        if ((_visibleLeft < _visibleRight) && (_visibleTop < _visibleBottom))
        {
            if (__active && __visible && (__animMode == BENTO_BUILD_FINISHED) && __CanHighlight())
            {
                if ((_pX >= _visibleLeft) && (_pY >= _visibleTop) && (_pX <= _visibleRight) && (_pY <= _visibleBottom))
                {
                    _highlightStruct = self;
                }
            }
            
            if (__captureClipChildren)
            {
                _limitLeft   = _visibleLeft;
                _limitTop    = _visibleTop;
                _limitRight  = _visibleRight;
                _limitBottom = _visibleBottom;
            }
            
            var _i = 0;
            repeat(array_length(__children))
            {
                var _childOver = __children[_i].__HighlightSearch(_pX, _pY, _limitLeft, _limitTop, _limitRight, _limitBottom);
                if (_childOver != undefined) _highlightStruct = _childOver;
                ++_i;
            }
        }
        
        __BentoContextStackPop();
        
        return _highlightStruct;
    }
    
    static __HighlightableNotInGroup = function(_excludeGroup)
    {
        return ((_excludeGroup == undefined) || (highlightGroup == undefined) || (_excludeGroup != highlightGroup));
    }
    
    static __HighlightableFreeSearch = function(_pX, _pY, _nX, _nY, _oldStruct, _limitLeft, _limitTop, _limitRight, _limitBottom, _excludeGroup, _result)
    {
        //TODO - Write an exception for scanning within scrollboxes
        
        var _visibleLeft   = __worldLeft;   //max(_limitLeft,   __worldLeft  );
        var _visibleTop    = __worldTop;    //max(_limitTop,    __worldTop   );
        var _visibleRight  = __worldRight;  //min(_limitRight,  __worldRight );
        var _visibleBottom = __worldBottom; //min(_limitBottom, __worldBottom);
        
        if ((_visibleLeft < _visibleRight) && (_visibleTop < _visibleBottom) && (__animMode == BENTO_BUILD_FINISHED))
        {
            if (__active && __visible && __CanCaptureClickAnyEver() && (_oldStruct != self) && __HighlightableNotInGroup(_excludeGroup))
            {
                var _distance = __HighlightableFreeSearchDistance(_pX, _pY, _nX, _nY);
                if (_distance < _result.__distance)
                {
                    _result.__struct   = self;
                    _result.__distance = _distance;
                }
            }
            
            if (__captureClipChildren)
            {
                _limitLeft   = _visibleLeft;
                _limitTop    = _visibleTop;
                _limitRight  = _visibleRight;
                _limitBottom = _visibleBottom;
            }
            
            var _i = 0;
            repeat(array_length(__children))
            {
                __children[_i].__HighlightableFreeSearch(_pX, _pY, _nX, _nY, _oldStruct, _limitLeft, _limitTop, _limitRight, _limitBottom, _excludeGroup, _result);
                ++_i;
            }
        }
    }
    
    static __HighlightableFreeSearchDistance = function(_pX, _pY, _nX, _nY)
    {
        var _closestX = clamp(_pX, __worldLeft, __worldRight);
        var _closestY = clamp(_pY, __worldTop, __worldBottom);
        
        var _dX = _closestX - _pX;
        var _dY = _closestY - _pY;
        
        if ((_dX == 0) && (_dY == 0))
        {
            var _dX = 0.5*(__worldLeft + __worldRight) - _pX;
            var _dY = 0.5*(__worldTop + __worldBottom) - _pY;
        }
        
        var _paraDist = _nX*_dX + _nY*_dY;
        var _perpDist = _nY*_dX - _nX*_dY;
        
        if (abs(_perpDist) > abs(_paraDist)) return infinity;
        if (_paraDist <= 0) return infinity;
        _perpDist *= 150 / _paraDist;
        
        return sqrt(_paraDist*_paraDist + _perpDist*_perpDist);
    }
    
    static __HighlightableSearchFirst = function()
    {
        var _openArray = [self];
        while(array_length(_openArray) > 0)
        {
            var _target = _openArray[0];
            with(_target)
            {
                if (__active)
                {
                    __BentoContextStackPush(self);
                    var _result = __CanHighlight();
                    __BentoContextStackPop();
                    
                    if (_result) return self;
                    
                    array_copy(_openArray, array_length(_openArray), __children, 0, array_length(__children));
                }
            }
            
            array_delete(_openArray, 0, 1);
        }
        
        return undefined;
    }
    
    static __CaptureCastSearch = function(_buttonName)
    {
        if (__active && (__animMode == BENTO_BUILD_FINISHED) && __CanRespondToButtonCast(_buttonName)) return self;
        return __parent.__CaptureCastSearch();
    }
    
    #endregion
}