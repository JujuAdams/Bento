// Feather disable all

/// @param attachedElement

function __BentoClassVariables(_attachedElement) constructor
{
    static _globalCount = 0;
    __envIndex = _globalCount++;
    
    if (BENTO_RUNNING_FROM_IDE)
    {
        global.BentoElementMap[? __envIndex] = self;
    }
    
    __attachedElement = _attachedElement;
    __elementIsInstance = __BentoIsInstance(_attachedElement);
    
    __name  = undefined;
    __layer = undefined;
    
    __disable        = false;
    __visible        = true;
    __buttonIndex    = undefined;
    __hoverableIndex = undefined;
    
    if (BENTO_ALLOW_ENCLOSED_GETTER)
    {
        __enclosed = false;
    }
    
    //Cartesian offset from the calculated layout position
    __offsetX = 0;
    __offsetY = 0;
    
    //Origin percentage bias, used for setting `bentoX` and `bentoY`
    __originX    = BENTO_DEFAULT_ORIGIN_X;
    __originY    = BENTO_DEFAULT_ORIGIN_Y;
    __originAuto = __elementIsInstance; //Instances default to auto origin
    
    __transformMatrix  = undefined;
    __transformOriginX = undefined;
    __transformOriginY = undefined;
    __transformOffsetX = 0;
    __transformOffsetY = 0;
    __transformOffsetAbsolute = false;
    __transformScaleX  = 1;
    __transformScaleY  = 1;
    __transformAngle   = 0;
    
    __hoverState       = __BENTO_STATE_OFF;
    __primaryState     = __BENTO_STATE_OFF;
    __primaryLongState = __BENTO_STATE_OFF;
    __byPlayer         = false;
    __clickState       = 0b00;
    
    __longPressEnabled = false;
    __clickTiming      = undefined;
    __pressTime        = -infinity;
    
    __carryItemState            = __BENTO_STATE_OFF;
    __carryItemContinuous       = true;
    __carryItemChannel          = undefined;
    __carryPointerDX            = 0;
    __carryPointerDY            = 0;
    __carryTargetChannel        = undefined;
    __carryTargetFunc           = undefined;
    __carryOnlyButtonWhenTarget = false;
    
    __textConfig = {
        __maxLength:      300,
        __caption:        "",
        __keyboardType:   kbv_type_default,
        __returnKey:      kbv_returnkey_default,
        __capitalization: kbv_autocapitalize_none,
        __textPrediction: false,
    };
    
    __parent    = BENTO_NO_ELEMENT;
    __drawDepth = 0;
    
    __forceStep            = false;
    __buttonType           = BENTO_BUTTON_NEVER;
    __executesStep         = false;
    __drawAfter            = false;
    __holdBlocksDragScroll = false;
    __backgroundHover      = BENTO_MAINTAIN_NAVIGATION;
    
    __focused          = false;
    __focusType        = BENTO_FOCUS_NONE;
    __focusEncloseType = BENTO_ENCLOSE_NEVER;
    
    __navigationLinkLeft  = BENTO_NO_ELEMENT;
    __navigationLinkRight = BENTO_NO_ELEMENT;
    __navigationLinkUp    = BENTO_NO_ELEMENT;
    __navigationLinkDown  = BENTO_NO_ELEMENT;
    
    //TODO - Combine into one variable using binary flags?
    __navigationEnableX = true;
    __navigationEnableY = true;
    __navigationWrapX   = false;
    __navigationWrapY   = false;
    
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
    __scissorVisibility  =  BENTO_VISIBLE_FULL;
    __scissorParent      =  self;
    
    __scissorScrollbarLeft    = 0;
    __scissorScrollbarTop     = 0;
    __scissorScrollbarRight   = 0;
    __scissorScrollbarBottom  = 0;
    
    __scrollHori        = false;
    __scrollVert        = false;
    __scrollPadLeft     = 0;
    __scrollPadTop      = 0;
    __scrollPadRight    = 0;
    __scrollPadBottom   = 0;
    __scrollX           = 0;
    __scrollY           = 0;
    __scrollTargetX     = 0;
    __scrollTargetY     = 0;
    __scrollSpeed       = infinity;
    __scrollMinX        = 0;
    __scrollMaxX        = 0;
    __scrollMinY        = 0;
    __scrollMaxY        = 0;
    __scrollCumulativeX = 0;
    __scrollCumulativeY = 0;
    
    __scrollContentWidth  = 0;
    __scrollContentHeight = 0;
    __scrollVisibleWidth  = 0;
    __scrollVisibleHeight = 0;
    
    __scrollbarHori = undefined;
    __scrollbarVert = undefined;
    
    __hoverOnDestroy = BENTO_NO_ELEMENT;
    
    __animPlaying  = false;
    __animBlocking = false;
    __animDuration = 1;
    __animDelay    = 0;
    __animMethod   = undefined;
    __animMetadata = undefined
    __animElapsed  = 0;
    
    
    
    if (__elementIsInstance)
    {
        __eventStep = method(_attachedElement, function()
        {
            event_user(BENTO_USER_EVENT_STEP);
        });
        
        __eventDraw = method(_attachedElement, function()
        {
            event_user(BENTO_USER_EVENT_DRAW);
        });
        
        __eventDrawAfter = method(_attachedElement, function()
        {
            event_user(BENTO_USER_EVENT_DRAW_AFTER);
        });
        
        __eventDrawHover = method(_attachedElement, function()
        {
            event_user(BENTO_USER_EVENT_DRAW_HOVER);
        });
        
        __eventDrawDragged = method(_attachedElement, function()
        {
            event_user(BENTO_USER_EVENT_DRAW_DRAGGED);
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
                event_user(BENTO_USER_EVENT_REPOSITION);
            }
        };
        
        __funcHover = method(_attachedElement, function(_mouseX, _mouseY)
        {
            if (instance_position(_mouseX, _mouseY, self))
            {
                var _scissorParent = BENTO_VARS.__scissorParent;
                if (point_in_rectangle(_mouseX, _mouseY, _scissorParent.__scissorWorldLeft, _scissorParent.__scissorWorldTop, _scissorParent.__scissorWorldRight, _scissorParent.__scissorWorldBottom))
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
            eventStep();
        });
        
        __eventDraw = method(_attachedElement, function()
        {
            eventDraw();
        });
        
        __eventDrawAfter = method(_attachedElement, function()
        {
            eventDrawAfter();
        });
        
        __eventDrawHover = method(_attachedElement, function()
        {
            eventDrawHover();
        });
        
        __eventDrawDragged = method(_attachedElement, function()
        {
            eventDrawDragged();
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
                eventReposition();
            }
        };
        
        __funcHover = method(_attachedElement, function(_mouseX, _mouseY)
        {
            if (point_in_rectangle(_mouseX, _mouseY, bentoLeft, bentoTop, bentoRight, bentoBottom))
            {
                var _scissorParent = BENTO_VARS.__scissorParent;
                if (point_in_rectangle(_mouseX, _mouseY, _scissorParent.__scissorWorldLeft, _scissorParent.__scissorWorldTop, _scissorParent.__scissorWorldRight, _scissorParent.__scissorWorldBottom))
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
    
    __eventStepScissorPush = method(self, __BentoStepScissorPushFromVars);
    __eventStepScissorPop  = method(self, __BentoStepScissorPop);
    //Draw variant of scissor functions are called directly in Draw Order methods (see `__BentoEnsureDrawOrder()`)
    
    static __Destroy = function()
    {
        __BentoRemoveParent(__attachedElement);
        BentoDestroyChildren(__attachedElement);
        
        if (BentoExists(__hoverOnDestroy))
        {
            BentoHoverSoft(__hoverOnDestroy);
        }
        
        BentoFocusClose(__attachedElement);
        
        var _element = __layer.__environment.__nameMap[? __name];
        if (_element == __attachedElement) ds_map_delete(__layer.__environment.__nameMap, __name);
        
        __layer.__dirtyFlags |= __BENTO_DIRTY_ALL;
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
        if (BENTO_FLOOR_LAYOUT_POSITIONS)
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
    
    __layoutChildArray = [];
    
    __layoutClampInside = false;
    
    //Anchor against the available space that the parent has allocated for this element. This is
    //especially useful for children of rect parents where you might want to position the element
    //relative to edges and corners.
    __layoutAnchorX = BENTO_DEFAULT_LAYOUT_ANCHOR_X;
    __layoutAnchorY = BENTO_DEFAULT_LAYOUT_ANCHOR_Y;
    
    //The "preferred" (ideal) size for the element. A value of 0 (or less) indicates that this value
    //is unset and should be inferred from some other property.
    __layoutWidthPref  = 0;
    __layoutHeightPref = 0;
    
    //The upper and lower bounds for the element. The preferred size is always clamped within this
    //range.
    __layoutWidthMin  = 0;
    __layoutHeightMin = 0;
    __layoutWidthMax  = infinity;
    __layoutHeightMax = infinity;
    
    __layoutPadLeft   = 0;
    __layoutPadTop    = 0;
    __layoutPadRight  = 0;
    __layoutPadBottom = 0;
    
    __layoutGutterX = 0;
    __layoutGutterY = 0;
    
    __solverPadLeft   = 0;
    __solverPadTop    = 0;
    __solverPadRight  = 0;
    __solverPadBottom = 0;
    
    //How the element should resize. All elements will always try to reduce in size, down to their
    //minimum size, if they are too big for their parent regardless of resizing logic.
    //
    //In addition to the above, `NORMAL` resizing does nothing extra. `INFLATE` will allow the element
    //to additionally *increase* in size to fill out available space. Finally, `DEFLATE` will
    //additionally cause the element to shrink down to the minimum size to fit its children.
    __layoutWidthResize  = BENTO_RESIZE_NORMAL;
    __layoutHeightResize = BENTO_RESIZE_NORMAL;
    
    //The size required to deflate all of this element's children at their preferred size.
    __solverDeflateWidth  = 0;
    __solverDeflateHeight = 0;
    
    //The size required to deflate all of this element's children at their preferred size.
    __solverChildrenDeflateWidth  = 0;
    __solverChildrenDeflateHeight = 0;
    
    //The absolute minimum size that a parent can be to fit all of its children.
    __solverMinWidth  = 0;
    __solverMinHeight = 0;
    
    __layoutType = BENTO_LAYOUT_RECT;
    
    //Function that sets the solver's deflate width and minimum width. This is a boring function for
    //most elements. It gets more exciting for lists - see `__BentoSolverListGetDeflateWidth()`. This
    //function also preliminarily sets the final calculated width for the element (`__solvedWidth`).
    __SolverGetDeflateWidth = method(self, __BentoSolverRectGetDeflateWidth);
    
    //Resizes both this element and any child elements that are set to "deflate" or "inflate" resize
    //types. See `__BentoSolverListResizeWidth()` and `__BentoSolverListResizeHeight()`.
    __SolverResizeWidth = method(self, __BentoSolverRectResizeWidth);
    
    //Function that sets the solver's deflate height and minimum height. This is a boring function for
    //most elements. It gets more exciting for lists - see `__BentoSolverListGetDeflateHeight()`. This
    //function also preliminarily sets the final calculated height for the element (`__solvedHeight`).
    __SolverGetDeflateHeight = method(self, __BentoSolverRectGetDeflateHeight);
    
    //Resizes both this element and any child elements that are set to "deflate" or "inflate" resize
    //types. See `__BentoSolverListResizeWidth()` and `__BentoSolverListResizeHeight()`.
    __SolverResizeHeight = method(self, __BentoSolverRectResizeHeight);
    
    //Final pass to set the element's position. Elements are given a region that they are permitted
    //to occupy. For elements that are children of "boring" (non-list, non-grid) parents, the
    //allocated space is equal to the full size of the parent. If an element is a parent of a list or
    //grid then the allocated space will be smaller.
    __SolverFinalPositions = method(self, __BentoSolverRectPositions);
    
    //Only used for `BENTO_LAYOUT_TEXT`
    __funcMeasureHeight = function() { return 1; }
}