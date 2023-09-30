/// A sprite, with the added capability to stretch it. Available in BentoScript using the
/// BentoSprite builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name    | Datatype | Purpose                                                                             |
/// |---------|----------|-------------------------------------------------------------------------------------|
/// | color   | RGB      | Blend color for the sprite                                                          |
/// | alpha   | number   | Alpha transparency                                                                  |
/// | sprite  | sprite   | Sprite to draw. You may use a string if BentoDebugRelaxedSprites() to set to <true> |
/// |         |          | N.B. Setting the sprite will also set the width/height of the UI element itself     |
/// | image   | number   | Image of the sprite to draw                                                         |
/// | stretch | boolean  | Whether or not to stretch the sprite over the bounding box                          |

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