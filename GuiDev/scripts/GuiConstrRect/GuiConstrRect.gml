// Feather disable all

/// @param [parent=self]

function GuiConstrRect(_parent = other) : GuiConstrAncestor(_parent) constructor
{
    GuiLayoutSetSize(sprite_get_width(sGuiMaskRectangle), sprite_get_height(sGuiMaskRectangle));
    GuiLayoutSetOrigin(sprite_get_xoffset(sGuiMaskRectangle) / sprite_get_width(sGuiMaskRectangle),
                       sprite_get_yoffset(sGuiMaskRectangle) / sprite_get_height(sGuiMaskRectangle));
    
    funcDraw = function()
    {
        draw_sprite_ext(sGuiMaskRectangle, 0,
                        guiX, guiY,
                        guiWidth/sprite_get_width(sGuiMaskRectangle), guiHeight/sprite_get_height(sGuiMaskRectangle), 0,
                        c_white, 1);
    }
}