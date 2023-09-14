/// A static sprite with blend color and alpha. The sprite will not animate
/// Normally a sprite is drawn in the center of the enclosing box. However, setting <stretch>
/// to <true> will cause the sprite to be stretched across the entire box. This is useful when
/// combined with GameMaker's native 9-slicing implementation to create attractive resizeable
/// backgrounds for boxes.
/// 
/// In addition to BentoClassShared() variables, public variables are:
///   color
///   alpha
///   sprite
///   image
///   stretch
/// 
/// This box has no callbacks or methods beyond BentoClassShared().

BentoAddBoxType("BentoSprite", BentoClassSprite, false);
function BentoClassSprite() : BentoClassShared() constructor
{
    /// Public variables ///
    color   = c_white;
    alpha   = 1;
    image   = 0;
    stretch = false;
    ////////////////////////
    
    __sprite = undefined;
    
    
    
    VariableBind("sprite", function()
    {
        return __sprite;
    },
    function(_value)
    {
        if (is_string(_value) && _debugStruct.__relaxedSprites)
        {
            _value = asset_get_index(_value);
        }
        
        __sprite = _value;
        
        if (sprite_exists(__sprite))
        {
            Set("size", [sprite_get_width(__sprite), sprite_get_height(__sprite)]);
        }
        else
        {
            Set("size", [0, 0]);
        }
    });
    
    
    
    CallbackSetDraw(function()
    {
        if ((__sprite != undefined) && sprite_exists(__sprite))
        {
            var _color = merge_color(color, animBlend, animBlendAmount);
            var _alpha = alpha*animAlpha;
            
            if (stretch)
            {
                draw_sprite_stretched_ext(__sprite, image, __drawLeft, __drawTop, __drawRight - __drawLeft, __drawBottom - __drawTop, _color, _alpha);
            }
            else
            {
                var _x = __drawLeft + __drawScale*sprite_get_xoffset(__sprite);
                var _y = __drawTop  + __drawScale*sprite_get_yoffset(__sprite);
                
                draw_sprite_ext(__sprite, image, _x, _y, __drawScale, __drawScale, 0, _color, _alpha);
            }
        }
    });
}