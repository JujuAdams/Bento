/// A surface-based clipping window that allows its contents to be offset. Useful for allowing
/// access to more content than would otherwise fit on the screen. Available in BentoScript using
/// the BentoScrollbox builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name       | Datatype | Purpose                                                              |
/// |------------|----------|----------------------------------------------------------------------|
/// | scrollX    | number   | x-axis offset for children                                           |
/// | scrollXMin | number   | Minimum x-axis offset for children                                   |
/// | scrollXMax | number   | Maximum x-axis offset for children                                   |
/// | scrollY    | number   | y-axis offset for children                                           |
/// | scrollYMin | number   | Minimum y-axis offset for children                                   |
/// | scrollYMax | number   | Maximum y-axis offset for children                                   |
/// | draggableX | boolean  | Whether the scroll box can be clicked and dragged to move the window |
/// | draggableY | boolean  | Whether the scroll box can be clicked and dragged to move the window |

BentoAddBoxType("BentoScrollbox", BentoClassScrollbox, false);
function BentoClassScrollbox() : BentoClassShared() constructor
{
    /// Public variables ///
    scrollX    = 0;
    scrollXMin = 0;
    scrollXMax = 0;
    scrollY    = 0;
    scrollYMin = 0;
    scrollYMax = 0;
    
    debugUseSurface = true;
    ////////////////////////
    
    __captureClipChildren = true;
    __surface = -1;
    
    __scrollDragOffsetX = 0;
    __scrollDragOffsetY = 0;
    
    static __ScrollTo = function(_target)
    {
        var _oldScrollX = scrollX;
        var _oldScrollY = scrollY;
        
        var _width  = Get("width");
        var _height = Get("height");
        
        var _targetLeft   = _target.__localLeft;
        var _targetTop    = _target.__localTop;
        var _targetRight  = _target.__localRight;
        var _targetBottom = _target.__localBottom;
        
        if (_targetLeft < 0)
        {
            if (_targetRight < _width)
            {
                scrollX = _targetLeft / __worldScale;
            }
            else
            {
                //Element is wider than the box
                scrollX = (_width/2 - _targetLeft/2) / __worldScale;
            }
        }
        else
        {
            if (_targetRight > _width)
            {
                scrollX = (_targetRight - _width) / __worldScale;
            }
            else
            {
                //Do nothing!
            }
        }
        
        if (_targetTop < 0)
        {
            if (_targetBottom < _height)
            {
                scrollY = _targetTop / __worldScale;
            }
            else
            {
                //Element is wider than the box
                scrollY = (_height/2 - _targetTop/2) / __worldScale;
            }
        }
        else
        {
            if (_targetBottom > _height)
            {
                scrollY = (_targetBottom - _height) / __worldScale;
            }
            else
            {
                //Do nothing!
            }
        }
        
        scrollX = clamp(scrollX, scrollXMin, scrollXMax);
        scrollY = clamp(scrollY, scrollYMin, scrollYMax);
        
        //If our scroll position has changed, immediately update the world space positions of our children
        if ((_oldScrollX != scrollX) || (_oldScrollY != scrollY))
        {
            __Step(__worldOffsetX, __worldOffsetY, __worldScale / __localScale, false);
        }
        
        __ScrollParentToSelf();
    }
    
    static __EnsureSurface = function(_width, _height)
    {
        var _new = false;
        
        if (not surface_exists(__surface))
        {
            _new = true;
        }
        else if ((surface_get_width( __surface) != _width) || (surface_get_height(__surface) != _height))
        {
            surface_free(__surface);
            _new = true;
        }
        
        if (_new)
        {
            __surface = __BentoSurfaceCreate(self, _width, _height);
        }
    }
    
    static __Step = function(_offsetX, _offsetY, _scale, _executeEvent)
    {
        __BentoContextStackPush(self);
        
        if (_executeEvent && (__animMode == BENTO_BUILD_IN))
        {
            ++__animTime;
            __EventGet(__BENTO_CALL.__BUILD_IN).__Call(self, __animTime);
            if (__animTime >= buildInLength) BuildFinish();
        }
        
        _offsetX += animXOffset;
        _offsetY += animYOffset;
        
        __worldScale = __localScale*_scale;
        
        //TODO - Apply scaling
        __worldOffsetX = _offsetX;
        __worldOffsetY = _offsetY;
        __worldLeft    = _offsetX + __worldScale*__localLeft;
        __worldTop     = _offsetY + __worldScale*__localTop;
        __worldRight   = _offsetX + __worldScale*__localRight;
        __worldBottom  = _offsetY + __worldScale*__localBottom;
        
        if (_executeEvent && __active) __EventGet(__BENTO_CALL.__STEP).__Call(self);
        
        var _i = 0;
        repeat(array_length(__children))
        {
            __children[_i].__Step(__worldLeft - __worldScale*scrollX, __worldTop - __worldScale*scrollY, __worldScale, _executeEvent);
            ++_i;
        }
        
        __BentoContextStackPop();
    }
    
    static __Draw = function(_offsetX, _offsetY, _scale)
    {
        __BentoContextStackPush(self);
        
        _offsetX += animXOffset;
        _offsetY += animYOffset;
        
        __drawScale = __localScale*animScale*_scale;
        
        //TODO - Apply scaling
        __drawOffsetX = _offsetX;
        __drawOffsetY = _offsetY;
        __drawLeft    = _offsetX + __drawScale*__localLeft;
        __drawTop     = _offsetY + __drawScale*__localTop;
        __drawRight   = _offsetX + __drawScale*__localRight;
        __drawBottom  = _offsetY + __drawScale*__localBottom;
        
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
            __EventGet(__BENTO_CALL.__DRAW).__Call(self);
        }
        
        if (debugUseSurface)
        {
            __EnsureSurface(Get("width"), Get("height"));
            
            surface_set_target(__surface);
            draw_clear_alpha(c_black, 0);
            
            var _i = 0;
            repeat(array_length(__children))
            {
                __children[_i].__Draw(-__drawScale*scrollX, -__drawScale*scrollY, __drawScale);
                ++_i;
            }
            
            surface_reset_target();
            
            draw_surface(__surface, __drawLeft, __drawTop);
        }
        else
        {
            var _i = 0;
            repeat(array_length(__children))
            {
                __children[_i].__Draw(__drawLeft - __drawScale*scrollX, __drawTop - __drawScale*scrollY, __drawScale);
                ++_i;
            }
        }
        
        __BentoContextStackPop();
    }
}