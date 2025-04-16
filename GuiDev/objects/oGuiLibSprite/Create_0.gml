// Feather disable all

event_inherited();

GuiSetIfNotDefined(id, "hAlign", fa_left);
GuiSetIfNotDefined(id, "vAlign", fa_top);

__SolverSetLayoutXY = function()
{
    layoutX = GuiRegionGetSpriteX(sprite_index, layoutLeft, layoutWidth,  hAlign);
    layoutY = GuiRegionGetSpriteY(sprite_index, layoutTop,  layoutHeight, vAlign);
}