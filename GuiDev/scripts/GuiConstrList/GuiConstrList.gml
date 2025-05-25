// Feather disable all

/// @param [parent=self]

function GuiConstrList(_parent = other) : GuiConstrAncestor(_parent) constructor
{
    GuiLayoutSetOrigin(sprite_get_xoffset(sGuiMaskRectangle) / sprite_get_width(sGuiMaskRectangle),
                       sprite_get_yoffset(sGuiMaskRectangle) / sprite_get_height(sGuiMaskRectangle));
    
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
        
        __SolverShrinkWidth  = method(self, __GuiSolverListShrinkWidth);
        __SolverResizeWidth  = method(self, __GuiSolverListResizeWidth);
        __SolverShrinkHeight = method(self, __GuiSolverListShrinkHeight);
        __SolverResizeHeight = method(self, __GuiSolverListResizeHeight);
        __SolverPositions    = method(self, __GuiSolverListPositions);
    }
    
    funcDraw = function()
    {
        draw_sprite_ext(sGuiMaskRectangle, 0,
                        guiX, guiY,
                        guiWidth/sprite_get_width(sGuiMaskRectangle), guiHeight/sprite_get_height(sGuiMaskRectangle), 0,
                        c_white, 1);
    }
}