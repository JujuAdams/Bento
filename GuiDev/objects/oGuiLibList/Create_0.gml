// Feather disable all

event_inherited();

with(GUI_VARS)
{
    __layoutGutterX = 0;
    __layoutGutterY = 0;
    
    __listAxis = GUI_AXIS_Y;
    
    __solverMinWidth  = 0;
    __solverMinHeight = 0;
    __solverShrinkWidth  = 0;
    __solverShrinkHeight = 0;
    
    __layoutHAlignChildren = fa_left;
    __layoutVAlignChildren = fa_top;
    
    __SolverShrinkWidth     = method(self, __GuiSolverListShrinkWidth);
    __SolverResizeWidth  = method(self, __GuiSolverListResizeWidth);
    __SolverShrinkHeight    = method(self, __GuiSolverListShrinkHeight);
    __SolverResizeHeight = method(self, __GuiSolverListResizeHeight);
    __SolverPositions    = method(self, __GuiSolverListPositions);
}