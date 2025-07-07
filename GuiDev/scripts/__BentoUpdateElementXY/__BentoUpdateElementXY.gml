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
            var _xPerc = BENTO_DEFAULT_ORIGIN_X;
            var _yPerc = BENTO_DEFAULT_ORIGIN_Y;
        }
        
    }
    else
    {
        //Otherwise use the static layout origin
        var _xPerc = BENTO_VARS.__originX;
        var _yPerc = BENTO_VARS.__originY;
    }
    
    bentoX = lerp(bentoLeft, bentoRight,  _xPerc);
    bentoY = lerp(bentoTop,  bentoBottom, _yPerc);
}