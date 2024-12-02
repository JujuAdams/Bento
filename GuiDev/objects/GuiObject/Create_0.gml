// Feather disable all

var _system = __GuiSystem();

// Guarantee that we have a sprite to ensure we always have a collision mask available.
if ((not sprite_exists(mask_index)) && (not sprite_exists(sprite_index)))
{
    sprite_index = GuiMaskBasic;
}

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

__xTarget = x;
__yTarget = y;

__overState = GUI_OFF;
__holdState = GUI_OFF;
__click     = false;

__parent = noone;
__inside = _system.__tempInside;
__GuiSetParent(id, _system.__tempParent, __inside);
__GuiSetIfNotDefined(id, "priority", 0);

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

__childInsideArray  = [];
__childOutsideArray = [];

__orderDirty = false;
__updating   = false;

__scrollEnabled   = false;
__tabIdent        = undefined;
__tabIdentChildOf = undefined;
__selectOnDestroy = noone;

__scissorState = false;
//Further scissor variables set in `GuiScrollSetRegionExt()`

__animating = false;

__guiIndex = __GuiSystem().__guiIndex;
__GuiSystem().__guiIndex++;