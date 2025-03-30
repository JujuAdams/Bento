// Feather disable all

event_inherited();

__layoutPadLeft   = 0
__layoutPadTop    = 0
__layoutPadRight  = 0
__layoutPadBottom = 0

__layoutGutterX = 0;
__layoutGutterY = 0;

__listAxis = GUI_AXIS_Y;

__solverMinWidth  = 0;
__solverMinHeight = 0;
__solverFitWidth  = 0;
__solverFitHeight = 0;

__alignChildrenH = fa_left;
__alignChildrenV = fa_top;

__SolverFitWidth     = method(self, __GuiSolverListFitWidth);
__SolverResizeWidth  = method(self, __GuiSolverListResizeWidth);
__SolverFitHeight    = method(self, __GuiSolverListFitHeight);
__SolverResizeHeight = method(self, __GuiSolverListResizeHeight);
__SolverPositions    = method(self, __GuiSolverListPositions);