// Feather disable all

/// Sets the behavior for a GUI instance. By default, an instance's behavior is set to
/// `GUI_BEHAVIOR_COSMETIC` meaning that it will be drawn but will not be interactible. Available
/// behavior constants are as follows:
/// 
/// - `GUI_BEHAVIOR_COSMETIC`
///   Instance will be drawn but will not be selectable nor interactible. The instance will not
///   have its Step user event called.
/// 
/// - `GUI_BEHAVIOR_BUTTON`
///   Instance will be selectable and interactible, including clicking use the primary action
///   input. The instance will still have its Step user event called. The instance will, naturally,
///   be drawn as well.
/// 
/// - `GUI_BEHAVIOR_LISTENER`
///   Instance will be drawn but will not be selectable. The instance will not be clickable using
///   the primary action input. The instance will still have its Step user event called, however,
///   and you can scan for button inputs using `GetNavGetButton()`.
/// 
/// - `GUI_BEHAVIOR_MODAL`
///   A variant on `GUI_BEHAVIOR_LISTENER` with the added effect of blocking all inputs passing
///   through to lower priority GUI instances. This is useful for confirmation questions that
///   should prevent player input until the question has been answered.
/// 
/// - `GUI_BEHAVIOR_POP_UP`
///   A variant on `GUI_BEHAVIOR_LISTENER` with the added effect of self-destructing when a GUI
///   instance with a lower priority is clicked. Unlike modals, pop-ups will not block inputs to
///   lower priority instances. When using the `GUI_NAV_GAMEPAD` mode, selection will be limited to
///   GUI instances inside the pop-up.
/// 
/// - `GUI_BEHAVIOR_BLOCK_SIBLINGS`
///   Prevents interaction and rendering for sibling instances with a lower priority. The instance
///   itself will still have its Step and Draw user event executed but it cannot be interacted with
///   directly using the primary action. This behavior is useful for creating pages.
/// 
/// @param [instance=id]
/// @param behavior

function GuiSetBehavior(_instance = id, _behavior)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    if (_instance.__behavior == _behavior) return;
    
    _system.__stepDirty = true;
    _system.__drawDirty = true;
    
    _instance.__behavior = _behavior;
}