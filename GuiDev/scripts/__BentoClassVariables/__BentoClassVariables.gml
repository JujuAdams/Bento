// Feather disable all

/// @param attachedInstance

function __BentoClassVariables(_attachedElement) constructor
{
    static _globalCount = 0;
    __envIndex = _globalCount++;
    
    if (GUI_RUNNING_FROM_IDE)
    {
        global.BentoElementMap[? __envIndex] = self;
    }
    
    __attachedElement = _attachedElement;
    __elementIsInstance = __BentoIsInstance(_attachedElement);
    
    __name  = undefined;
    __layer = undefined;
    
    __disable        = false;
    __visible        = true;
    __hoverableIndex = undefined;
    
    __offsetX = 0;
    __offsetY = 0;
    
    __transformMatrix  = undefined;
    __transformOriginX = undefined;
    __transformOriginY = undefined;
    __transformOffsetX = 0;
    __transformOffsetY = 0;
    __transformOffsetAbsolute = false;
    __transformScaleX  = 1;
    __transformScaleY  = 1;
    __transformAngle   = 0;
    
    __hoverState   = __GUI_OFF;
    __primaryState = __GUI_OFF;
    __click        = false;
    
    __textConfig = {
        __maxLength:      300,
        __caption:        "",
        __keyboardType:   kbv_type_default,
        __returnKey:      kbv_returnkey_default,
        __capitalization: kbv_autocapitalize_none,
        __textPrediction: false,
    };
    
    __parent     = GUI_NO_ELEMENT;
    __localIndex = 0;
    __drawDepth  = 0;
    
    __forceStep    = false;
    __buttonType   = GUI_BUTTON_NEVER;
    __executesStep = false;
    __drawAfter    = false;
    
    __focused          = false;
    __focusType        = GUI_FOCUS_POINTER_CANCEL_ALWAYS;
    __focusEncloseType = GUI_ENCLOSE_NEVER;
    
    __linkLeft  = GUI_NO_ELEMENT;
    __linkRight = GUI_NO_ELEMENT;
    __linkUp    = GUI_NO_ELEMENT;
    __linkDown  = GUI_NO_ELEMENT;
    
    __raycastDisableHori = false;
    __raycastDisableVert = false;
    
    __childArray     = [];
    __childDrawArray = [];
    
    __drawOrderDirty    = false;
    __scrollLimitsDirty = false;
    __offsetDirty       = false;
    __transformDirty    = false;
    
    __updating = false;
    
    __scissorEnabled   = false;
    __scissorPadLeft   = 0;
    __scissorPadTop    = 0;
    __scissorPadRight  = 0;
    __scissorPadBottom = 0;
    
    __scissorWorldLeft   = -infinity
    __scissorWorldTop    = -infinity
    __scissorWorldRight  =  infinity
    __scissorWorldBottom =  infinity
    __scissorVisibility  = GUI_VISIBLE_FULL;
    
    __scissorScrollbarLeft    = 0;
    __scissorScrollbarTop     = 0;
    __scissorScrollbarRight   = 0;
    __scissorScrollbarBottom  = 0;
    
    __scrollHori      = false;
    __scrollVert      = false;
    __scrollPadLeft   = 0;
    __scrollPadTop    = 0;
    __scrollPadRight  = 0;
    __scrollPadBottom = 0;
    __scrollX         = 0;
    __scrollY         = 0;
    __scrollTargetX   = 0;
    __scrollTargetY   = 0;
    __scrollSpeed     = infinity;
    __scrollMinX      = 0;
    __scrollMaxX      = 0;
    __scrollMinY      = 0;
    __scrollMaxY      = 0;
    
    __scrollbarHori = undefined;
    __scrollbarVert = undefined;
    
    __selectOnDestroy = GUI_NO_ELEMENT;
    
    if (__elementIsInstance)
    {
        __eventStep = method(_attachedElement, function()
        {
            event_user(GUI_USER_EVENT_STEP);
        });
        
        __eventDraw = method(_attachedElement, function()
        {
            event_user(GUI_USER_EVENT_DRAW);
        });
        
        __eventDrawAfter = method(_attachedElement, function()
        {
            event_user(GUI_USER_EVENT_DRAW_AFTER);
        });
        
        __eventReposition = function()
        {
            //TODO - Improve efficiency
            
            if (__scrollbarVert != undefined)
            {
                __scrollbarVert.__SetSize();
            }
            
            if (__scrollbarHori != undefined)
            {
                __scrollbarHori.__SetSize();
            }
            
            with(__attachedElement)
            {
                event_user(GUI_USER_EVENT_REPOSITION);
            }
        };
        
        __funcHover = method(_attachedElement, function(_mouseX, _mouseY)
        {
            if (instance_position(_mouseX, _mouseY, self))
            {
                var _guiVars = GUI_VARS;
                if (point_in_rectangle(_mouseX, _mouseY, _guiVars.__scissorWorldLeft, _guiVars.__scissorWorldTop, _guiVars.__scissorWorldRight, _guiVars.__scissorWorldBottom))
                {
                    return self;
                }
                else
                {
                    return undefined;
                }
            }
            else
            {
                return undefined;
            }
        });
    }
    else
    {
        __eventStep = method(_attachedElement, function()
        {
            funcStep();
        });
        
        __eventDraw = method(_attachedElement, function()
        {
            funcDraw();
        });
        
        __eventDrawAfter = method(_attachedElement, function()
        {
            funcDrawAfter();
        });
        
        __eventReposition = function()
        {
            //TODO - Improve efficiency
            
            if (__scrollbarVert != undefined)
            {
                __scrollbarVert.__SetSize();
            }
            
            if (__scrollbarHori != undefined)
            {
                __scrollbarHori.__SetSize();
            }
            
            with(__attachedElement)
            {
                funcReposition();
            }
        };
        
        __funcHover = method(_attachedElement, function(_mouseX, _mouseY)
        {
            if (point_in_rectangle(_mouseX, _mouseY, guiLeft, guiTop, guiRight, guiBottom))
            {
                var _guiVars = GUI_VARS;
                if (point_in_rectangle(_mouseX, _mouseY, _guiVars.__scissorWorldLeft, _guiVars.__scissorWorldTop, _guiVars.__scissorWorldRight, _guiVars.__scissorWorldBottom))
                {
                    return self;
                }
                else
                {
                    return undefined;
                }
            }
            else
            {
                return undefined;
            }
        });
    }
    
    __eventScissorPush = method(_attachedElement, __BentoScissorPushFromElement);
    __eventScissorPop  = method(_attachedElement, __BentoScissorPop);
    
    static __Destroy = function()
    {
        __BentoRemoveParent(__attachedElement);
        BentoDestroyChildren(__attachedElement);
        
        if (BentoExists(__selectOnDestroy))
        {
            BentoSelectSoft(__selectOnDestroy);
        }
        
        BentoFocusClose(__attachedElement);
        
        var _element = __layer.__nameMap[? __name];
        if (_element == __attachedElement) ds_map_delete(__layer.__nameMap, __name);
        
        __layer.__dirtyFlags |= __GUI_DIRTY_ALL;
    }
    
    /////////////////////////////////
    //                             //
    //  Layout & Solver Variables  //
    //                             //
    /////////////////////////////////
    
    //Output values from the solver. Positions are relative to the left-top of the parent. All four
    //values are subsequently transforms to give us the `layout*` values that are exposed to the user.
    if (__elementIsInstance)
    {
        if (GUI_FLOOR_LAYOUT_POSITIONS)
        {
            __solvedLeft   = floor(_attachedElement.x);
            __solvedTop    = floor(_attachedElement.y);
            __solvedWidth  = floor(_attachedElement.sprite_width);
            __solvedHeight = floor(_attachedElement.sprite_height);
        }
        else
        {
            __solvedLeft   = _attachedElement.x;
            __solvedTop    = _attachedElement.y;
            __solvedWidth  = _attachedElement.sprite_width;
            __solvedHeight = _attachedElement.sprite_height;
        }
    }
    else
    {
        __solvedLeft   = 0;
        __solvedTop    = 0;
        __solvedWidth  = 0;
        __solvedHeight = 0;
    }
    
    __layoutClampInside = false;
    
    //Alignment against the region that the parent has allocated for this instance. This is especially
    //useful for children of non-list / non-grid parents where you might want to position the instance
    //relative to edges and corners.
    __layoutAlignH = GUI_DEFAULT_LAYOUT_ALIGN_H;
    __layoutAlignV = GUI_DEFAULT_LAYOUT_ALIGN_V;
    
    //Origin position, used for setting `guiX` and `guiY`
    __layoutOriginX = 0;
    __layoutOriginY = 0;
    __layoutOriginAuto = __elementIsInstance; //Instances default to auto origin
    
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
    
    __solverPadLeft   = 0;
    __solverPadTop    = 0;
    __solverPadRight  = 0;
    __solverPadBottom = 0;
    
    //How the instance should resize. "Static" is as the name suggests - the instance won't change
    //size. "Shrink" will cause the instance to shrink down to shrink any children it has inside. If an
    //instance has no ch\ildren, the "shrink" resize type will behave the same as "static". "expand" will
    //cause the instance to increase size in that axis to fill available space in the parent.
    __layoutWidthResize  = GUI_RESIZE_STATIC;
    __layoutHeightResize = GUI_RESIZE_STATIC;
    
    //The size required to shrink all of this instance's children at their preferred size.
    __solverGetShrinkWidth  = 0;
    __solverGetShrinkHeight = 0;
    
    //The absolute minimum size that a parent can be to shrink all of its children.
    __solverMinWidth  = 0;
    __solverMinHeight = 0;
    
    __layoutType = GUI_LAYOUT_RECT;
    
    //Function that sets the solver's shrink width and minimum width. This is a boring function for most
    //instances. It gets more exciting for lists - see `__BentoSolverListGetShrinkWidth()`. This function also
    //preliminarily sets the final calculated width for the instance (`__solvedWidth`).
    //
    // N.B. `GUI_LAYOUT_LIST` and `GUI_LAYOUT_TEXT` override this function.
    __SolverGetShrinkWidth = method(self, __BentoSolverRectGetShrinkWidth);
    
    //Resizes both this instance and any child instances that are set to "shrink" or "expand" resize types.
    //See `__BentoSolverListResizeWidth()` and `__BentoSolverListResizeHeight()`.
    //
    // N.B. `GUI_LAYOUT_LIST` and `GUI_LAYOUT_GRID` override this function.
    __SolverResizeWidth = function()
    {
        //Do nothing
    }
    
    //Function that sets the solver's shrink height and minimum height. This is a boring function for most
    //instances. It gets more exciting for lists - see `__BentoSolverListGetShrinkHeight()`. This function also
    //preliminarily sets the final calculated height for the instance (`__solvedHeight`).
    //
    // N.B. `GUI_LAYOUT_LIST` and `GUI_LAYOUT_TEXT` override this function.
    __SolverGetShrinkHeight = method(self, __BentoSolverRectGetShrinkHeight);
    
    //Resizes both this instance and any child instances that are set to "shrink" or "expand" resize types.
    //See `__BentoSolverListResizeWidth()` and `__BentoSolverListResizeHeight()`.
    //
    // N.B. `GUI_LAYOUT_LIST` and `GUI_LAYOUT_GRID` override this function.
    __SolverResizeHeight = function()
    {
                
        //Do nothing
    }
    
    //Final pass to set the instance's position. Instances are given a region that they are permitted
    //to occupy. For instances that are children of "boring" (non-list, non-grid) parents, the
    //allocated space is equal to the full size of the parent. If an instance is a parent of a list or
    //grid then the allocated space will be smaller.
    //
    // N.B. `GUI_LAYOUT_LIST` and `GUI_LAYOUT_GRID` override this function.
    __SolverPositions = method(self, __BentoSolverRectPositions);
    
    //Only used for `GUI_LAYOUT_TEXT`
    __funcMeasureWidth  = function() { return 1; }
    __funcMeasureHeight = function() { return 1; }
}