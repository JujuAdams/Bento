function __BentoClassHost(_name) constructor
{
    static _global = __BentoGlobal();
    array_push(_global.__hostArray, weak_ref_create(self));
    
    __name = _name ?? BentoRandomUUID();
    
    __worldLeft   = 0;
    __worldTop    = 0;
    __worldRight  = display_get_gui_width();
    __worldBottom = display_get_gui_height();
    
    __layerArray = []; //Ordered as highest priority first
    
    __inputMode         = BENTO_INPUT_MODE_POINTER;
    __inputX            = 0;
    __inputY            = 0;
    __inputExcludeGroup = false;
    __inputRetrigger    = false;
    __inputThreshold    = 0.2;
    __inputButtonArray  = [];
    __inputButtonDict   = {};
    
    if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Created ", self);
    
    
    
    
    
    #region General
    
    static toString = function()
    {
        return "<host " + __name + ">";
    }
    
    static __HostLTRB = function(_left, _top, _right, _bottom)
    {
        if (array_length(__layerArray) > 0)
        {
            __BentoTrace("Warning! ", self, " has layers, setting the world LTRB will not be reflected by already existing layers.");
            __BentoTrace("It is recommended to call BentoClear() and rebuild your UI entirely");
        }
        
        __worldLeft   = _left;
        __worldTop    = _top;
        __worldRight  = _right;
        __worldBottom = _bottom;
        
        return self;
    }
    
    static __Step = function()
    {
        //Since the layer array can change whilst processing inputs, we need to cache layers
        var _layerArray = array_create(array_length(__layerArray), undefined);
        array_copy(_layerArray, 0, __layerArray, 0, array_length(__layerArray));
        
        var _oldHost = _global.__currentHost;
        _global.__currentHost = self;
        
        //Distribute inputs amongst layers
        //We stop when we hit a modal (a layer with behavior greater than 1)
        var _i = 0;
        repeat(array_length(_layerArray))
        {
            var _layer = _layerArray[_i];
            _layer.__InputProcess(__inputMode, __inputX, __inputY, __inputRetrigger, __inputThreshold, __inputExcludeGroup, __inputButtonArray);
            
            ++_i;
            
            //Don't let input go beyond modals
            if (_layer.behavior >= BENTO_BEHAVIOR_MODAL) break;
        }
        
        //Reset button state for all remaining layers after a modal
        var _clearHighlight = (__inputMode == BENTO_INPUT_MODE_POINTER);
        repeat(array_length(_layerArray) - _i)
        {
            _layerArray[_i].__InputClearAll(_clearHighlight);
            ++_i;
        }
        
        //Then run the standard per-frame Step callbacks
        var _i = 0;
        repeat(array_length(_layerArray))
        {
            _layerArray[_i].__Step();
            ++_i;
        }
        
        //Clean up any deleted layers from the official layer array
        var _i = 0;
        repeat(array_length(__layerArray))
        {
            var _layer = __layerArray[_i];
            if (_layer.__destroyed)
            {
                array_delete(__layerArray, _i, 1);
            }
            else
            {
                ++_i;
            }
        }
        
        //Reset volatile input state
        __inputRetrigger = false;
        
        if (__inputMode == BENTO_INPUT_MODE_DIRECTIONAL)
        {
            __inputX = 0;
            __inputY = 0;
        }
        
        var _i = 0;
        repeat(array_length(__inputButtonArray))
        {
            __inputButtonArray[_i].__state = false;   
            ++_i;
        }
        
        _global.__currentHost = _oldHost;
    }
    
    static __Draw = function()
    {
        var _oldHost = _global.__currentHost;
        _global.__currentHost = self;
        
        //Search for a blocking layer to draw up to
        var _last = 0;
        repeat(array_length(__layerArray))
        {
            ++_last;
            if (__layerArray[_last-1].behavior >= BENTO_BEHAVIOR_BLOCKING) break;
        }
        
        //Draw backwards
        var _i = _last-1;
        repeat(_last)
        {
            __layerArray[_i].__Draw();
            --_i;
        }
        
        _global.__currentHost = _oldHost;
    }
    
    static __Clear = function()
    {
        array_resize(__layerArray, 0);
    }
    
    static __LayerAnyBehaviorInput = function()
    {
        //FIXME - Cache this value
        
        var _i = 0;
        repeat(array_length(__layerArray))
        {
            if (__layerArray[_i].behavior >= BENTO_BEHAVIOR_PASSTHROUGH) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __LayerAnyBehaviorModal = function()
    {
        //FIXME - Cache this value
        
        var _i = 0;
        repeat(array_length(__layerArray))
        {
            if (__layerArray[_i].behavior >= BENTO_BEHAVIOR_MODAL) return true;
            ++_i;
        }
        
        return false;
    }
    
    #endregion
    
    
    
    
    
    #region Layers
    
    static __LayerAddTop = function(_layer)
    {
        _layer.__priority = (array_length(__layerArray) == 0)? 0 : __layerArray[0].__priority;
        array_insert(__layerArray, 0, _layer);
    }
    
    static __LayerMoveToPriority = function(_layer, _priority)
    {
        _layer.__priority = _priority;
        array_delete(__layerArray, __BentoArrayFindIndex(__layerArray, _layer), 1);
        
        var _i = 0;
        repeat(array_length(__layerArray))
        {
            if (__layerArray[_i].__priority <= _priority) break;
            ++_i;
        }
        
        array_insert(__layerArray, _i, _layer);
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Moved ", _layer, " to priority=", _priority);
    }
    
    static __LayerMoveToTop = function(_layer, _incrementPriority = 0)
    {
        _layer.__priority = __layerArray[0].__priority + _incrementPriority;
        
        array_delete(__layerArray, _index, 1);
        array_insert(__layerArray, 0, _layer);
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Moved ", _layer, " to the top, priority=", _layer.__priority);
    }
    
    static __LayerMoveOver = function(_layer, _targetName)
    {
        if (_layer.__name == _targetName) return; // ???
        
        var _currentIndex = __BentoArrayFindIndex(__layerArray, _layer);
        
        var _targetIndex = __GetIndex(_targetName);
        if (_targetIndex == undefined) __BentoError("Target layer \"", _targetName, "\" doesn't exist for ", self);
        
        if (_currentIndex == _targetIndex-1) return; //Already over the top of the target
        
        var _targetLayer = __layerArray[_targetIndex];
        _layer.__priority = _targetLayer.__priority;
        
        array_delete(__layerArray, _currentIndex, 1);
        array_insert(__layerArray, _targetIndex, _layer);
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Moved ", _layer, " over ", _targetLayer, ", priority=", _layer.__priority);
    }
    
    static __LayerSustain = function(_name)
    {
        var _layerStruct = __GetLayer(_name);
        if (is_struct(_layerStruct))
        {
            _layerStruct.__VolatileKeepAlive();
            return true;
        }
        
        return false;
    }
    
    static __LayerDelete = function(_name)
    {
        var _index = __GetIndex(_name);
        if (_index == undefined) return; //Stop, stop, he's already dead
        
        var _layer = __layerArray[_index];
        array_delete(__layerArray, _index, 1);
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Deleted ", _layer);
    }
    
    #endregion
    
    
    
    
    
    #region Layer Getters
    
    static __GetLayer = function(_name)
    {
        var _index = __GetIndex(_name);
        return (_index == undefined)? undefined : __layerArray[_index];
    }
    
    static __GetLayerCount = function()
    {
        return array_length(__layerArray);
    }
    
    static __LayerExists = function(_name)
    {
        return (__GetIndex(_name) != undefined);
    }
    
    static __GetIndex = function(_name)
    {
        var _i = 0;
        repeat(array_length(__layerArray))
        {
            if (__layerArray[_i].__name == _name) return _i;
            ++_i;
        }
        
        return undefined;
    }
    
    static __GetStruct = function(_name)
    {
        var _layer = __GetLayer(_name);
        if (_layer == undefined) return undefined;
        return _layer.__struct;
    }
    
    static __GetPriority = function(_name)
    {
        var _layer = __GetLayer(_name);
        if (_layer == undefined) return undefined;
        return _layer.__priority;
    }
    
    static __GetBehavior = function(_name)
    {
        var _layer = __GetLayer(_name);
        if (_layer == undefined) return undefined;
        return _layer.behavior;
    }
    
    static __GetTopLayer = function()
    {
        return (array_length(__layerArray) <= 0)? undefined : __layerArray[0].__name;
    }
    
    #endregion
    
    
    
    
    
    #region Input
    
    static __InputSetMode = function(_mode)
    {
        if ((_mode == BENTO_INPUT_MODE_DIRECTIONAL) && (__inputMode != BENTO_INPUT_MODE_DIRECTIONAL))
        {
            var _i = 0;
            repeat(array_length(__layerArray))
            {
                __layerArray[_i].__HighlightFirst(true);
                ++_i;
            }
        }
        
        __inputMode = _mode;
    }
    
    static __InputGetMode = function()
    {
        return __inputMode;
    }
    
    static __InputPointer = function(_x, _y)
    {
        __InputSetMode(BENTO_INPUT_MODE_POINTER);
        
        __inputX = _x;
        __inputY = _y;
        
        return self;
    }
    
    static __InputDirection = function(_dX, _dY, _retrigger = false, _threshold = 0.2, _excludeGroup = false)
    {
        __InputSetMode(BENTO_INPUT_MODE_DIRECTIONAL);
        
        __inputX            = _dX;
        __inputY            = _dY;
        __inputRetrigger    = _retrigger;
        __inputThreshold    = _threshold;
        __inputExcludeGroup = _excludeGroup;
        
        return self;
    }
    
    static __InputButtonTarget = function(_name, _state)
    {
        var _buttonData = __inputButtonDict[$ _name];
        if (_buttonData == undefined)
        {
            _buttonData = {
                __type:  "target",
                __name:  _name,
                __state: _state,
            };
            
            __inputButtonDict[$ _name] = _buttonData;
            array_push(__inputButtonArray, _buttonData);
        }
        else
        {
            _buttonData.__state = _state;
        }
        
        return self;
    }
    
    static __InputButtonCast = function(_name, _state)
    {
        var _buttonData = __inputButtonDict[$ _name];
        if (_buttonData == undefined)
        {
            _buttonData = {
                __type:  "cast",
                __name:  _name,
                __state: _state,
            };
            
            __inputButtonDict[$ _name] = _buttonData;
            array_push(__inputButtonArray, _buttonData);
        }
        else
        {
            _buttonData.__state = _state;
        }
        
        return self;
    }
    
    #endregion
    
    
    
    
    
    static __FileOriginSearch = function(_filePathArray, _resultArray)
    {
        var _i = 0;
        repeat(array_length(__layerArray))
        {
            __layerArray[_i].__FileOriginSearch(_filePathArray, _resultArray);
            ++_i;
        }
        
        return _resultArray;
    }
}