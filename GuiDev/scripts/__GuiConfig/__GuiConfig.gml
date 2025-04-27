// Feather disable all

// What room layer to create instances on when using `GuiCreate()`. Use `undefined` to
// instead create instances using a particular depth see `GUI_CREATE_DEPTH`.
#macro GUI_CREATE_LAYER  undefined

// What depth to create instances on when using `GuiCreate()`. This macro will only be used
// if `GUI_CREATE_LAYER` is set to `undefined`.
#macro GUI_CREATE_DEPTH  0

// How far the pointer must move before engaging scrolling when clicking and dragging.
#macro GUI_SCROLL_THRESHOLD  4

// Whether the primary action should trigger a click on press rather than on release when using a
// pointer.
#macro GUI_POINTER_CLICK_ON_PRESS  false

// How far to scroll when scrolling with a mouse wheel. Set this value to `0` to disable mouse
// wheel scrolling (or just don't use `GUI_HOTKEY_MOUSE_WHEEL_UP` or `GUI_HOTKEY_MOUSE_WHEEL_DOWN`).
#macro GUI_MOUSE_WHEEL_SCROLL_SPEED  20

// Whether clicking and dragging on a scrollable UI element should scroll in the `GUI_NAV_MOUSE`
// nav mode.
#macro GUI_SCROLL_ON_MOUSE_DRAG  true

// Whether pop-ups will allow you to click instances behind the pop-up. If this macro is set to
// `true` then instances can be highlighted and clicked. Setting this macro to `false` will prevent
// background instances from being clicked but the pop-up will still be destroyed.
#macro GUI_POP_UP_CLICK_THROUGH  false

// Button names to use to enable mouse wheel scrolling with `GuiScrollOnPointer()`. This macros
// should be used with `GuiInputHotkey()` to trigger scrolling.
#macro GUI_HOTKEY_MOUSE_WHEEL_UP    "mouse wheel up"
#macro GUI_HOTKEY_MOUSE_WHEEL_DOWN  "mouse wheel down"

// Normally, desktop OSs will default to setting the navigation mode to `GUI_NAV_MOUSE` when the
// library initializes. Set this macro to `true` to instead default to `GUI_NAV_DIRECTIONAL`.
#macro GUI_DESKTOP_DEFAULT_TO_DIRECTIONAL  false

// Debug only. Set this macro to `true` to show verbose output in the debug log that shows which
// instances are being hovered / un-hovered.
#macro GUI_VERBOSE_OVER_STATE  false

// Functions to call when showing debug messages. Set this macro to `undefined` to disable all
// debug messages.
#macro GUI_SHOW_DEBUG_MESSAGE  show_debug_message

// Function to call when showing errors. (These cannot be disabled!)
#macro GUI_SHOW_ERROR  show_error

#macro GUI_JSON_CHILDREN_STRING_PROCESSOR  undefined

#macro GUI_DEFAULT_LAYOUT_ALIGN_H  0
#macro GUI_DEFAULT_LAYOUT_ALIGN_V  0

#macro GUI_SCROLL_TO_PADDING  10

#macro GUI_DEFAULT_SCROLL_SPEED  8

#macro GUI_STRUCT  __guiVars