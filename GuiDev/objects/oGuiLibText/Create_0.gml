// Feather disable all

event_inherited();

GuiSetIfNotDefined("text", "");
GuiSetIfNotDefined("font", -1);
GuiSetIfNotDefined("hAlign", fa_left);
GuiSetIfNotDefined("vAlign", fa_top);

with(GUI_VARS)
{
    __SolverShrinkWidth  = method(self, __GuiSolverTextShrinkWidth);
    __SolverShrinkHeight = method(self, __GuiSolverTextShrinkHeight);
}