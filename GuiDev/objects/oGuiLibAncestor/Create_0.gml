// Feather disable all

var _system = __GuiSystem();

// Guarantee that we have a sprite to ensure we always have a collision mask available.
if ((not sprite_exists(mask_index)) && (not sprite_exists(sprite_index)))
{
    sprite_index = sGuiMaskRectangle;
}

GuiSetIfNotDefined("navLeft",  noone);
GuiSetIfNotDefined("navRight", noone);
GuiSetIfNotDefined("navUp",    noone);
GuiSetIfNotDefined("navDown",  noone);

GuiSetIfNotDefined("scrollMarginLeft",   6);
GuiSetIfNotDefined("scrollMarginRight",  6);
GuiSetIfNotDefined("scrollMarginTop",    6);
GuiSetIfNotDefined("scrollMarginBottom", 6);

///////////////////////////
//                       //
//  Read-Only Variables  //
//                       //
///////////////////////////

layoutLeft   = x - image_xscale*sprite_get_xoffset(sprite_index);
layoutTop    = y - image_yscale*sprite_get_yoffset(sprite_index);
layoutWidth  = sprite_width;
layoutHeight = sprite_height;

/////////////////////////
//                     //
//  Private Variables  //
//                     //
/////////////////////////

__animXOffset    = 0;
__animYOffset    = 0;
__animXScale     = 1;
__animYScale     = 1;
__animScaleForce = false;
__animAngle      = 0;
__animAngleForce = false;

__editorRootInstance = undefined;

__overState = GUI_OFF;
__holdState = GUI_OFF;
__click     = false;

__parent   = noone;
__priority = 0;
GuiSetParent(_system.__tempParent, id);

__behavior = GUI_BEHAVIOR_COSMETIC;
__drawEnd  = false;

persistent = true;

__name = undefined;

__disable = false;

__focusable       = false;
__focused         = false;
__focusBlockHover = false;

__raycastDisableHori = false;
__raycastDisableVert = false;

__childArray = [];

__orderDirty = false;
__updating   = false;

__scrollEnabled = false;
__scrollX       = 0;
__scrollY       = 0;

__tabIdent        = undefined;
__tabIdentChildOf = undefined;
__selectOnDestroy = noone;

__scissorState = false;
//Further scissor variables set in `GuiScrollSetRegionExt()`

__animating = false;

////////////////////////
//                    //
//  Layout Variables  //
//                    //
////////////////////////

__layoutXOffset      = 0;
__layoutYOffset      = 0;
__layoutWidthPref    = sprite_width;
__layoutHeightPref   = sprite_height;
__layoutWidthMin     = 0;
__layoutHeightMin    = 0;
__layoutWidthMax     = infinity;
__layoutHeightMax    = infinity;
__layoutWidthResize  = GUI_RESIZE_STATIC;
__layoutHeightResize = GUI_RESIZE_STATIC;
__layoutHAlign       = fa_center;
__layoutVAlign       = fa_middle;

__solverFitWidth  = 0;
__solverFitHeight = 0;
__solverMinWidth  = 0;
__solverMinHeight = 0;

__SolverFitWidth = function()
{
    // N.B. `oGuiLibList`, `oGuiLibText` override this function.
    
    layoutWidth      = clamp(__layoutWidthPref, __layoutWidthMin, __layoutWidthMax);
    __solverFitWidth = layoutWidth;
    __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : layoutWidth;
}

__SolverResizeWidth = function()
{
    // N.B. `oGuiLibList`, `oGuiLibGrid` override this function.
    
    //Do nothing
}

__LayoutReflowText = function()
{
    // N.B. `oGuiLibText` overrides this function.
    
    //Do nothing
}

__SolverFitHeight = function()
{
    // N.B. `oGuiLibList`, `oGuiLibText` override this function.
    
    layoutHeight      = clamp(__layoutHeightPref, __layoutHeightMin, __layoutHeightMax);
    __solverFitHeight = layoutHeight;
    __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : layoutHeight;
}

__SolverResizeHeight = function(_maxWidth)
{
    // N.B. `oGuiLibList`, `oGuiLibGrid` override this function.
    
    //Do nothing
}

__SolverPositions = function(_left, _top, _parentWidth, _parentHeight)
{
    // N.B. `oGuiLibList`, `oGuiLibGrid` overrides this function.
    
    if (__layoutHAlign == fa_center)
    {
        _left += 0.5*(_parentWidth - layoutWidth);
    }
    else if (__layoutVAlign == fa_right)
    {
        _left += _parentWidth - layoutWidth;
    }
    
    if (__layoutVAlign == fa_middle)
    {
        _top += 0.5*(_parentHeight - layoutHeight);
    }
    else if (__layoutVAlign == fa_bottom)
    {
        _top += _parentHeight - layoutHeight;
    }
    
    _left += __layoutXOffset;
    _top  += __layoutYOffset;
    
    layoutLeft = _left;
    layoutTop  = _top;
    
    var _width  = layoutWidth;
    var _height = layoutHeight;
    
    var _childArray = __childArray;
    var _i = 0;
    repeat(array_length(_childArray))
    {
        _childArray[_i].__SolverPositions(_left, _top, _width, _height);
        ++_i;
    }
}