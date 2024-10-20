// Feather disable all

var _system = __GuiSystem();

__GuiSetIfNotDefined(id, "width",  0);
__GuiSetIfNotDefined(id, "height", 0);

__GuiSetIfNotDefined(id, "navLeft",  noone);
__GuiSetIfNotDefined(id, "navRight", noone);
__GuiSetIfNotDefined(id, "navUp",    noone);
__GuiSetIfNotDefined(id, "navDown",  noone);

__GuiSetIfNotDefined(id, "scrollMarginLeft",   6);
__GuiSetIfNotDefined(id, "scrollMarginRight",  6);
__GuiSetIfNotDefined(id, "scrollMarginTop",    6);
__GuiSetIfNotDefined(id, "scrollMarginBottom", 6);

/////////////////////////
//                     //
//  Private Variables  //
//                     //
/////////////////////////

overState = GUI_OFF;
holdState = GUI_OFF;
click     = false;

__parent = noone;
__inside = _system.__tempInside;
__GuiSetParent(id, _system.__tempParent, __inside);
__GuiSetIfNotDefined(id, "priority", 0);

__behavior = GUI_BEHAVIOR_COSMETIC;
__drawEnd  = false;

persistent = true;

__name = undefined;

__disable = false;
__raycastDisableHori = false;
__raycastDisableVert = false;

__childInsideArray  = [];
__childOutsideArray = [];

__orderDirty = false;
__updating   = false;

__scrollEnabled = false;
__tabsEnabled = false;
__tabsHost = noone;
__selectOnDestroy = noone;

__scissorState = false;
//Further scissor variables set in `GuiScissorSetupExt()`

__animating = false;

__guiIndex = __GuiSystem().__guiIndex;
__GuiSystem().__guiIndex++;