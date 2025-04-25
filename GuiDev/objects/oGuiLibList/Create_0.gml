// Feather disable all

event_inherited();

with(__gui)
{
    __layoutGutterX = 0;
    __layoutGutterY = 0;
    
    __listAxis = GUI_AXIS_Y;
    
    __solverMinWidth  = 0;
    __solverMinHeight = 0;
    __solverFitWidth  = 0;
    __solverFitHeight = 0;
    
    __layoutHAlignChildren = fa_left;
    __layoutVAlignChildren = fa_top;
    
    __SolverFitWidth     = method(self, __GuiSolverListFitWidth);
    __SolverResizeWidth  = method(self, __GuiSolverListResizeWidth);
    __SolverFitHeight    = method(self, __GuiSolverListFitHeight);
    __SolverResizeHeight = method(self, __GuiSolverListResizeHeight);
    __SolverPositions    = method(self, __GuiSolverListPositions);
}