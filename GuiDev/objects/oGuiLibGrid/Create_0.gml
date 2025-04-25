// Feather disable all

event_inherited();

with(__gui)
{
    __layoutGutterX = 0;
    __layoutGutterY = 0;
    
    __gridColumns = 1;
    __gridRows    = 1;
    
    __SolverResizeWidth  = method(self, __GuiSolverGridResizeWidth);
    __SolverResizeHeight = method(self, __GuiSolverGridResizeHeight);
    __SolverPositions    = method(self, __GuiSolverGridPositions);
}