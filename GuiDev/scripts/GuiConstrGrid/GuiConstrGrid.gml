// Feather disable all

/// @param [parent=self]

function GuiConstrGrid(_parent = other) : GuiConstrAncestor(_parent) constructor
{
    GuiLayoutSetOrigin(sprite_get_xoffset(sGuiMaskRectangle) / sprite_get_width(sGuiMaskRectangle),
                       sprite_get_yoffset(sGuiMaskRectangle) / sprite_get_height(sGuiMaskRectangle));
    
    with(GUI_VARS)
    {
        __layoutGutterX = 0;
        __layoutGutterY = 0;
        
        __gridColumns = 1;
        __gridRows    = 1;
        
        __SolverResizeWidth  = method(self, __GuiSolverGridResizeWidth);
        __SolverResizeHeight = method(self, __GuiSolverGridResizeHeight);
        __SolverPositions    = method(self, __GuiSolverGridPositions);
    }
    
    funcDraw = function()
    {
        draw_sprite_ext(sGuiMaskRectangle, 0,
                        guiX, guiY,
                        guiWidth/sprite_get_width(sGuiMaskRectangle), guiHeight/sprite_get_height(sGuiMaskRectangle), 0,
                        c_white, 1);
    }
}