// Feather disable all

/// Starts focusing on an element. Generally speaking, only the focused element or descendents of
/// the focused element will be hoverable. This will completely restrict interaction inside the
/// focused container. This is especially helpful for setting up contextual regions of the user
/// interface without needing to create and manage new layers.
/// 
/// You must specify a particular focus type which controls how the element focus interacts with
/// the pointer. All focus types will restrict the what elements can be hovered in navigation
/// input modes (as above). The focus type must be one of the following constants:
/// 
/// `BENTO_FOCUS_POINTER_IGNORE`
///     Pointer ignores focus. Any part of the tree can be interacted with whilst the focus is in
///     operation.
/// 
/// `BENTO_FOCUS_POINTER_CANCEL_ON_CLICK`
///     Clicking outside of the focused part of the free will cancel the focus.
/// 
/// `BENTO_FOCUS_POINTER_DESTROY_ON_CLICK`
///     Clicking off of the focused part of the tree will destroy the focused element.
/// 
/// `BENTO_FOCUS_POINTER_CANCEL_ALWAYS`
///     Focus is cancelled automatically if the input mode is set to `BENTO_MODE_POINTER`.
/// 
/// `BENTO_FOCUS_POINTER_CONSTRAIN`
///     Pointer is constrained inside the focused part of the tree. The user will not be able to
///     hover, hold, or click elements outside of the focused part of the tree.
///     N.B. You should be careful with this focus type as it is possible to softlock your game!
/// 
/// You may stack focused elements provided that all focused elements are ancestors/descendents of
/// each other in the tree. This means you can have e.g. context menus inside context menus if you
/// so desire. Opening the focus for an element will close the focus for any other element that is
/// not an ancestor.
/// 
/// N.B. Elements that are receiving text input by calling `BentoTextOpen()` will override focus
///      rules whilst text input is open.
/// 
/// @param focusType
/// @param [element=self]


function BentoFocusOpen(_focusType, _element = self)
{
    with(__BentoGetVars(_element))
    {
        var _layer = __layer;
        
        __focusType = _focusType;
        
        //If the player is using a pointer but we want to always cancel focus when using a pointer
        //then sort that out
        if (_layer.__inputModePointer && (_focusType == BENTO_FOCUS_POINTER_CANCEL_ALWAYS))
        {
            BentoFocusClose(_element);
            return;
        }
        
        if (not __focused)
        {
            __focused = true;
            _layer.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
            
            var _focusStack = __layer.__focusStack;
            
            var _i = array_length(_focusStack)-1;
            if (_i >= 0)
            {
                var _focusElement = undefined;
                repeat(array_length(_focusStack))
                {
                    var _stackElement = _focusStack[_i].__focusElement;
                    if (BentoIsAncestor(_stackElement, _element))
                    {
                        _focusElement = _stackElement;
                        break;
                    }
                    
                    --_i;
                }
                
                BentoFocusClose(_focusElement);
            }
            
            array_push(_focusStack, {
                __prevHoverElement: _layer.__hoverElement,
                __focusElement: _element,
            });
            
            _layer.__focusTop = _element;
            
            _layer.__cursorLastL = _element.bentoLeft;
            _layer.__cursorLastT = _element.bentoTop;
            _layer.__cursorLastR = _element.bentoRight;
            _layer.__cursorLastB = _element.bentoBottom;
            
            if (__scissorEnabled)
            {
                //Use the smaller scissor region
                _layer.__navigationLastX = _element.bentoLeft + __scissorPadLeft + __scissorScrollbarLeft;
                _layer.__navigationLastY = _element.bentoTop  + __scissorPadTop + __scissorScrollbarTop;
            }
            else
            {
                _layer.__navigationLastX = _element.bentoLeft;
                _layer.__navigationLastY = _element.bentoTop;
            }
        }
    }
}