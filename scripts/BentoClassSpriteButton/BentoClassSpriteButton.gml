/// A sprite that can be clicked. When interacted with, the sprite can change image/color etc.
/// Please note that the size of the enclosing box is determined by the <sprite> variable i.e.
/// the initial "neutral" sprite.
/// 
/// Make sure to set <clickListen> and <callbackClick> to activate the button!
/// 
/// In addition to BentoClassShared() variables, public variables are:
///   sprite
///   image
///   color
///   highlightSprite
///   highlightImage
///   highlightColor
///   heldSprite
///   heldImage
///   heldColor
///   alpha
///   stretch
/// 
/// This box has no callbacks or methods beyond BentoClassShared().

BentoAddBoxType("BentoSpriteButton", BentoClassSpriteButton, false);
function BentoClassSpriteButton() : BentoClassButton() constructor
{
    /// Public variables ///
    color       = c_white;
    alpha       = 1;
    image       = 0;
    heldSprite  = undefined;
    heldImage   = undefined;
    heldColor   = c_lime;
    highlightSprite = undefined;
    highlightImage  = undefined;
    highlightColor  = c_yellow;
    stretch     = false;
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
            if (GetButton())
            {
                var _sprite = (heldSprite ?? highlightSprite) ?? __sprite;
                var _image  = (heldImage  ?? highlightImage ) ?? image;
                var _color  = (heldColor  ?? highlightColor ) ?? color;
            }
            else if (GetHighlight())
            {
                var _sprite = highlightSprite ?? __sprite;
                var _image  = highlightImage  ?? image;
                var _color  = highlightColor  ?? color;
            }
            else
            {
                var _sprite = __sprite;
                var _image  = image;
                var _color  = color;
            }
            
            _color = merge_color(_color, animBlend, animBlendAmount);
            var _alpha = alpha*animAlpha;
            
            if (stretch)
            {
                draw_sprite_stretched_ext(_sprite, _image, __drawLeft, __drawTop, __drawRight - __drawLeft, __drawBottom - __drawTop, _color, _alpha);
            }
            else
            {
                var _x = __drawLeft + __drawScale*sprite_get_xoffset(_sprite);
                var _y = __drawTop  + __drawScale*sprite_get_yoffset(_sprite);
                
                draw_sprite_ext(_sprite, _image, _x, _y, __drawScale, __drawScale, 0, _color, _alpha);
            }
        }
    });
}