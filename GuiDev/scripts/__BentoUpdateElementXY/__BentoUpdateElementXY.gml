// Feather disable all

/// Should be called in the scope of an element.

function __BentoUpdateElementXY()
{
    var _vars = BENTO_VARS;
    if (_vars.__originAuto)
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
        var _xPerc = _vars.__originX;
        var _yPerc = _vars.__originY;
    }
    
    if (_vars.__transformMatrix == undefined)
    {
        bentoX = lerp(bentoLeft, bentoRight,  _xPerc);
        bentoY = lerp(bentoTop,  bentoBottom, _yPerc);
    }
    else
    {
        //If we have a transform matrix then we need to update it when our x/y changes
        
        var _oldX = bentoX;
        var _oldY = bentoY;
        
        bentoX = lerp(bentoLeft, bentoRight,  _xPerc);
        bentoY = lerp(bentoTop,  bentoBottom, _yPerc);
        
        if ((bentoX != _oldX) || (bentoY != _oldY))
        {
            with(_vars)
            {
                __BentoMarkTransformDirty();
            }
        }
    }
}