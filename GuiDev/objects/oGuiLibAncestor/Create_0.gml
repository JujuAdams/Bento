// Feather disable all

var _system = __GuiSystem();

//Library instances are expected to persist between rooms.
persistent = true;

// Guarantee that we have a sprite to ensure we always have a collision mask available.
if ((not sprite_exists(mask_index)) && (not sprite_exists(sprite_index)))
{
    sprite_index = sGuiMaskRectangle;
}

GuiSetIfNotDefined("navLeft",  noone);
GuiSetIfNotDefined("navRight", noone);
GuiSetIfNotDefined("navUp",    noone);
GuiSetIfNotDefined("navDown",  noone);

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

__overState = GUI_OFF;
__holdState = GUI_OFF;
__click     = false;

__parent   = noone;
__priority = 0;
GuiSetParent(_system.__tempParent, id);

__behavior = GUI_BEHAVIOR_COSMETIC;
__drawEnd  = false;

__name = undefined;

__disable = false;

__focusable       = false;
__focused         = false;
__focusBlockHover = false;

__raycastDisableHori = false;
__raycastDisableVert = false;

__childArray = [];

//This variable is set on demand by various functions
__priorityDirty = false;

//This variable is set on demand by various functions
//__scrollLimitsDirty = false;

__updating = false;

__scissorEnabled = false;
//Further scissor variables set in `GuiScissorSetEnabled()`

__scrollHori = false;
__scrollVert = false;
//Further scroll variables set in `GuiScrollSetEnabled()`
__scrollX    = 0;
__scrollY    = 0;

__tabIdent        = undefined;
__tabIdentChildOf = undefined;
__selectOnDestroy = noone;

__animating = false;

/////////////////////////////////
//                             //
//  Layout & Solver Variables  //
//                             //
/////////////////////////////////

//Fixed offset applied against the calculated layout left/top position. Applied at the very end of
//the solver algorithm.
__layoutXOffset = 0;
__layoutYOffset = 0;

//Alignment against the region that the parent has allocated for this instance. This is especially
//useful for children of non-list / non-grid parents where you might want to position the instance
//relative to edges and corners.
__layoutHAlign = fa_center;
__layoutVAlign = fa_middle;

//The "preferred" (ideal) size for the instance. A value of 0 (or less) indicates that this value
//is unset and should be inferred from some other property.
__layoutWidthPref  = sprite_width;
__layoutHeightPref = sprite_height;

//The upper and lower bounds for the instance. The preferred size is always clamped within this
//range.
__layoutWidthMin  = 0;
__layoutHeightMin = 0;
__layoutWidthMax  = infinity;
__layoutHeightMax = infinity;

//How the instance should resize. "Static" is as the name suggests - the instance won't change
//size. "Fit" will cause the instance to shrink down to fit any children it has inside. If an
//instance has no ch\ildren, the "fit" resize type will behave the same as "static". "Grow" will
//cause the instance to increase size in that axis to fill available space in the parent.
__layoutWidthResize  = GUI_RESIZE_STATIC;
__layoutHeightResize = GUI_RESIZE_STATIC;

//The size required to fit all of this instance's children at their preferred size.
__solverFitWidth  = 0;
__solverFitHeight = 0;

//The absolute minimum size that a parent can be to fit all of its children.
__solverMinWidth  = 0;
__solverMinHeight = 0;

//Function that sets the solver's fit width and minimum width. This is a boring function for most
//instances. It gets more exciting for lists - see `__GuiSolverListFitWidth()`. This function also
//preliminarily sets the final calculated width for the instance (`layoutWidth`).
__SolverFitWidth = function()
{
    // N.B. `oGuiLibList`, `oGuiLibText` override this function.
    layoutWidth = clamp(__layoutWidthPref, __layoutWidthMin, __layoutWidthMax);
    
    __solverFitWidth = layoutWidth;
    __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : layoutWidth;
}

//Resizes both this instance and any child instances that are set to "fit" or "grow" resize types.
//See `__GuiSolverListResizeWidth()` and `__GuiSolverListResizeHeight()`.
__SolverResizeWidth = function()
{
    // N.B. `oGuiLibList`, `oGuiLibGrid` override this function.
    
    //Do nothing
}

//Adjusts the instance's width based on new parameters received from the solver.
__LayoutReflow = function()
{
    // N.B. `oGuiLibText` overrides this function.
    
    //Do nothing
    
    //TODO - Implement constant aspect ratio here?
}

//Function that sets the solver's fit height and minimum height. This is a boring function for most
//instances. It gets more exciting for lists - see `__GuiSolverListFitHeight()`. This function also
//preliminarily sets the final calculated height for the instance (`layoutHeight`).
__SolverFitHeight = function()
{
    // N.B. `oGuiLibList`, `oGuiLibText` override this function.
    layoutHeight = clamp(__layoutHeightPref, __layoutHeightMin, __layoutHeightMax);
    
    __solverFitHeight = layoutHeight;
    __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : layoutHeight;
}

//Resizes both this instance and any child instances that are set to "fit" or "grow" resize types.
//See `__GuiSolverListResizeWidth()` and `__GuiSolverListResizeHeight()`.
__SolverResizeHeight = function(_maxWidth)
{
    // N.B. `oGuiLibList`, `oGuiLibGrid` override this function.
    
    //Do nothing
}

//Final pass to set the instance's position. Instances are given a region that they are permitted
//to occupy. For instances that are children of "boring" (non-list, non-grid) parents, the
//allocated space is equal to the full size of the parent. If an instance is a parent of a list or
//grid then the allocated space will be smaller.
__SolverPositions = function(_left, _top, _allocatedWidth, _allocatedHeight)
{
    // N.B. `oGuiLibList`, `oGuiLibGrid` overrides this function.
    
    if (__layoutHAlign == fa_center)
    {
        _left += 0.5*(_allocatedWidth - layoutWidth);
    }
    else if (__layoutVAlign == fa_right)
    {
        _left += _allocatedWidth - layoutWidth;
    }
    
    if (__layoutVAlign == fa_middle)
    {
        _top += 0.5*(_allocatedHeight - layoutHeight);
    }
    else if (__layoutVAlign == fa_bottom)
    {
        _top += _allocatedHeight - layoutHeight;
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