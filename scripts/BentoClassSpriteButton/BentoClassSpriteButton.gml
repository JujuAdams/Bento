/// A button drawn using a sprite. When interacted with, the sprite can change image/color etc.
/// Available in BentoScript using the BentoSpriteButton builder.
/// 
/// Don't forget to set the .targetListen and .click variables! Buttons will be highlightable but
/// won't do anything if you don't set BOTH variables. For example:
/// 
///     build BentoSpriteButton {
///         //Receive events from the left mouse button
///         targetListen = "action"
///         
///         //Then tell the UI system what to do when we're clicked
///         click = fn {
///             Log("Ping!")
///         }
///     }
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name        | Datatype | Purpose                                                                                                            |
/// |-------------|----------|--------------------------------------------------------------------------------------------------------------------|
/// | sprite      | sprite   | Sprite to draw when in a neutral state. You may use a string if BentoDebugRelaxedSprites() to set to <true>        |
/// |             |          | N.B. Setting the sprite will also set the width/height of the UI element itself                                    |
/// | image       | number   | Image of the sprite to draw when in a neutral state                                                                |
/// | color       | RGB      | Blend color for the button when in a neutral state                                                                 |
/// | hoverSprite | sprite   | Sprite to draw when the button is highlighted. You may use a string if BentoDebugRelaxedSprites() to set to <true> |
/// | hoverImage  | number   | Image of the sprite to draw when the button is highlighted                                                         |
/// | hoverColor  | RGB      | Blend color for the button when highlighted                                                                        |
/// | heldSprite  | sprite   | Sprite to draw when the button is pressed. You may use a string if BentoDebugRelaxedSprites() to set to <true>     |
/// | heldImage   | number   | Image of the sprite to draw when the button is pressed                                                             |
/// | heldColor   | RGB      | Blend color for the button when pressed                                                                            |
/// | alpha       | number   | Alpha transparency                                                                                                 |
/// | stretch     | boolean  | Whether or not to stretch the sprite over the bounding box                                                         |

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