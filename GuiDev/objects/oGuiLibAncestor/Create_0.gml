// Feather disable all

var _system = __GuiSystem();

//Library instances are expected to persist between rooms.
persistent = true;

// Guarantee that we have a sprite to ensure we always have a collision mask available.
if ((not sprite_exists(mask_index)) && (not sprite_exists(sprite_index)))
{
    sprite_index = sGuiMaskRectangle;
}

///////////////////////////
//                       //
//  Read-Only Variables  //
//                       //
///////////////////////////

guiX      = x;
guiY      = y;
guiWidth  = sprite_width;
guiHeight = sprite_height;
guiAngle  = image_angle;
    
/////////////////////////
//                     //
//  Private Variables  //
//                     //
/////////////////////////

GUI_STRUCT = {};
with(GUI_STRUCT)
{
    __attachedInstance = other.id;
    
    if (__GUI_DEBUG)
    {
        var _globalCount = _system.__debugGlobalCount;
        ++_globalCount;
        _system.__debugGlobalCount = _globalCount;
        
        __debugUUID = __GuiMakeUUID(other.id, other.object_index, _globalCount);
        _system.__debugDict[$ __debugUUID] = self;
    }
    
    __animOriginX    = undefined;
    __animOriginY    = undefined;
    __animOffsetX    = 0;
    __animOffsetY    = 0;
    __animScaleX     = 1;
    __animScaleY     = 1;
    __animScaleForce = false;
    __animAngle      = 0;
    __animAngleForce = false;
    
    __overState = GUI_OFF;
    __holdState = GUI_OFF;
    __click     = false;
    
    __parent   = noone;
    __priority = 0;
    GuiSetParent(_system.__tempParent, other.id);
    
    __behavior = GUI_BEHAVIOR_COSMETIC;
    __drawEnd  = false;
    
    __name = undefined;
    
    __disable = false;
    
    __focusable       = false;
    __focused         = false;
    __focusBlockHover = false;
    
    __navLeft  = noone;
    __navRight = noone;
    __navUp    = noone;
    __navDown  = noone;
    
    __raycastDisableHori = false;
    __raycastDisableVert = false;
    
    __childArray = [];
    
    //This variable is set on demand by various functions
    __childOrderDirty = false;
    
    //This variable is set on demand by various functions
    __scrollLimitsDirty = false;
    
    __animAndScrollDirty = false;
    
    __updating = false;
    
    __scissorEnabled = false;
    //Further scissor variables set in `GuiScissorSetEnabled()`
    
    __scrollHori = false;
    __scrollVert = false;
    //Further scroll variables set in `GuiScrollSetEnabled()`
    __scrollX = 0;
    __scrollY = 0;
    
    __tabIdent        = undefined;
    __tabIdentChildOf = undefined;
    __selectOnDestroy = noone;
    
    __animating = false;
    
    /////////////////////////////////
    //                             //
    //  Layout & Solver Variables  //
    //                             //
    /////////////////////////////////
    
    //Output values from the solver. Positions are relative to the left-top of the parent. All four
    //values are subsequently transforms to give us the `layout*` values that are exposed to the user.
    __solvedLeftLocal = other.x;
    __solvedTopLocal  = other.y;
    __solvedWidth     = other.sprite_width;
    __solvedHeight    = other.sprite_height;
    
    //Fixed offset applied against the calculated layout left/top position. Applied at the very end of
    //the solver algorithm.
    __layoutOffsetX = 0;
    __layoutOffsetY = 0;
    
    //Alignment against the region that the parent has allocated for this instance. This is especially
    //useful for children of non-list / non-grid parents where you might want to position the instance
    //relative to edges and corners.
    __layoutAlignH = GUI_DEFAULT_LAYOUT_ALIGN_H;
    __layoutAlignV = GUI_DEFAULT_LAYOUT_ALIGN_V;
    
    //The "preferred" (ideal) size for the instance. A value of 0 (or less) indicates that this value
    //is unset and should be inferred from some other property.
    __layoutWidthPref  = 0;
    __layoutHeightPref = 0;
    
    //The upper and lower bounds for the instance. The preferred size is always clamped within this
    //range.
    __layoutWidthMin  = 0;
    __layoutHeightMin = 0;
    __layoutWidthMax  = infinity;
    __layoutHeightMax = infinity;
    
    __layoutPadLeft   = 0;
    __layoutPadTop    = 0;
    __layoutPadRight  = 0;
    __layoutPadBottom = 0;
    
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
    //preliminarily sets the final calculated width for the instance (`__solvedWidth`).
    __SolverFitWidth = function()
    {
        // N.B. `oGuiLibList`, `oGuiLibText` override this function.
        __solvedWidth = clamp((__layoutWidthPref > 0)? __layoutWidthPref : (sprite_exists(__attachedInstance.sprite_index)? sprite_get_width(__attachedInstance.sprite_index) : __layoutWidthMin), __layoutWidthMin, __layoutWidthMax);
        
        __solverFitWidth = __solvedWidth;
        __solverMinWidth = (__layoutWidthMin > 0)? __layoutWidthMin : __solvedWidth;
    }
    
    //Resizes both this instance and any child instances that are set to "fit" or "grow" resize types.
    //See `__GuiSolverListResizeWidth()` and `__GuiSolverListResizeHeight()`.
    __SolverResizeWidth = function()
    {
        // N.B. `oGuiLibList`, `oGuiLibGrid` override this function.
        
        //Do nothing
    }
    
    //Function that sets the solver's fit height and minimum height. This is a boring function for most
    //instances. It gets more exciting for lists - see `__GuiSolverListFitHeight()`. This function also
    //preliminarily sets the final calculated height for the instance (`__solvedHeight`).
    __SolverFitHeight = function()
    {
        // N.B. `oGuiLibList`, `oGuiLibText` override this function.
        __solvedHeight = clamp((__layoutHeightPref > 0)? __layoutHeightPref : (sprite_exists(__attachedInstance.sprite_index)? sprite_get_height(__attachedInstance.sprite_index) : __layoutHeightMin), __layoutHeightMin, __layoutHeightMax);
        
        __solverFitHeight = __solvedHeight;
        __solverMinHeight = (__layoutHeightMin > 0)? __layoutHeightMin : __solvedHeight;
    }
    
    //Resizes both this instance and any child instances that are set to "fit" or "grow" resize types.
    //See `__GuiSolverListResizeWidth()` and `__GuiSolverListResizeHeight()`.
    __SolverResizeHeight = function()
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
        // N.B. `____oGuiLibRoot`, `oGuiLibList`, `oGuiLibGrid` override this function.
        
        __solvedLeftLocal = _left + __layoutOffsetX + __layoutAlignH*(_allocatedWidth  - __solvedWidth );
        __solvedTopLocal  = _top  + __layoutOffsetY + __layoutAlignV*(_allocatedHeight - __solvedHeight);
        
        var _childX      = __layoutPadLeft;
        var _childY      = __layoutPadTop;
        var _childWidth  = __solvedWidth  - (__layoutPadLeft + __layoutPadRight);
        var _childHeight = __solvedHeight - (__layoutPadTop + __layoutPadBottom);
        
        var _childArray = __childArray;
        var _i = 0;
        repeat(array_length(_childArray))
        {
            _childArray[_i].GUI_STRUCT.__SolverPositions(_childX, _childY, _childWidth, _childHeight);
            ++_i;
        }
    }
}