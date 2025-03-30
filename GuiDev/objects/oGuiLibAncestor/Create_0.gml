// Feather disable all

var _system = __GuiSystem();

// Guarantee that we have a sprite to ensure we always have a collision mask available.
if ((not sprite_exists(mask_index)) && (not sprite_exists(sprite_index)))
{
    sprite_index = sGuiMaskRectangle;
}

__GuiSetIfNotDefined(id, "navLeft",  noone);
__GuiSetIfNotDefined(id, "navRight", noone);
__GuiSetIfNotDefined(id, "navUp",    noone);
__GuiSetIfNotDefined(id, "navDown",  noone);

__GuiSetIfNotDefined(id, "scrollMarginLeft",   6);
__GuiSetIfNotDefined(id, "scrollMarginRight",  6);
__GuiSetIfNotDefined(id, "scrollMarginTop",    6);
__GuiSetIfNotDefined(id, "scrollMarginBottom", 6);

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

__solverFitWidth  = 0;
__solverFitHeight = 0;
__solverMinWidth  = 0;
__solverMinHeight = 0;

__SolverFitWidth = function()
{
    layoutWidth      = clamp(__layoutWidthPref, __layoutWidthMin, __layoutWidthMax);
    __solverFitWidth = layoutWidth;
    __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : layoutWidth;
}

__SolverResizeWidth = function()
{
    //Do nothing
}

__LayoutReflowText = function()
{
    //Do nothing
}

__SolverFitHeight = function()
{
    layoutHeight      = clamp(__layoutHeightPref, __layoutHeightMin, __layoutHeightMax);
    __solverFitHeight = layoutHeight;
    __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : layoutHeight;
}

__SolverResizeHeight = function(_maxWidth)
{
    //Do nothing
}

__SolverPositions = function(_x, _y)
{
    _x += __layoutXOffset;
    _y += __layoutYOffset;
    
    layoutLeft = _x;
    layoutTop  = _y;
    
    var _childArray = __childArray;
    var _i = 0;
    repeat(array_length(_childArray))
    {
        _childArray[_i].__SolverPositions(_x, _y);
        ++_i;
    }
}