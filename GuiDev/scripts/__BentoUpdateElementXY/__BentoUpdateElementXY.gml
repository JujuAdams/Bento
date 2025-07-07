// Feather disable all

function __BentoUpdateElementXY()
{
    if (BENTO_VARS.__originAuto)
    {
        //If we're in auto mode, try to calculate the origin based on the instance's sprite
        var _sprite = sprite_index;
        if (sprite_exists(_sprite))
        {
            var _xPerc = sprite_get_xoffset(_sprite) / sprite_get_width(_sprite);
            var _yPerc = sprite_get_yoffset(_sprite) / sprite_get_height(_sprite);
        }
        else
        {
            //Fall back on the default alignment if we have no sprite
            var _xPerc = BENTO_DEFAULT_LAYOUT_ALIGN_H;
            var _yPerc = BENTO_DEFAULT_LAYOUT_ALIGN_V;
        }
        
        bentoX = lerp(bentoLeft, bentoRight,  _xPerc);
        bentoY = lerp(bentoTop,  bentoBottom, _yPerc);
    }
    else
    {
        //Otherwise use the static layout origin
        bentoX = bentoLeft + BENTO_VARS.__originX;
        bentoY = bentoTop  + BENTO_VARS.__originY;
    }
}