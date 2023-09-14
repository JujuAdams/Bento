/// A scrolling container, useful for allowing access to more content than would otherwise
/// fit on a screen.
/// 
/// In addition to BentoClassShared() variables, public variables are:
///   scrollX
///   scrollY
/// 
/// This box has no callbacks or methods beyond BentoClassShared().

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
    ////////////////////////
    
    __captureClipChildren = true;
    __surface = -1;
    
    __scrollDragOffsetX = 0;
    __scrollDragOffsetY = 0;
    
    
    
    
    
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
    
    static __Step = function(_offsetX, _offsetY)
    {
        __BentoContextStackPush(self);
        
        if (__animMode == BENTO_BUILD_IN)
        {
            ++__animTime;
            __CallbackGet(__BENTO_CALL.__BUILD_IN).__Call(self, __animTime);
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
        
        if (__active) __CallbackGet(__BENTO_CALL.__STEP).__Call(self);
        
        var _i = 0;
        repeat(array_length(__children))
        {
            __children[_i].__Step(__worldLeft - __worldScale*scrollX, __worldTop - __worldScale*scrollY, __worldScale);
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
            __CallbackGet(__BENTO_CALL.__DRAW).__Call(self);
        }
        
        __EnsureSurface();
        
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
        
        __BentoContextStackPop();
    }
}