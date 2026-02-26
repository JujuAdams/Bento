// Feather disable all

/// This constructor defines a simple sprite element that can be used within a Bento UI layout.
/// Sprites drawn by struct built by this constructor will be stretched across the element and as
/// such ninesliced sprites will work correctly.
/// 
/// Example:
/// ```
/// new BentoConstrSprite(sprite_index);
/// ```
///
/// @param sprite
/// @param [parent=self]

function BentoConstrSprite(_sprite, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    sprite = _sprite;
    
    //Copy the sprite size for the element size
    BentoLayoutSetSize(sprite_get_width(sprite), sprite_get_height(sprite));
    
    //Set the origin. Origins are proportional in Bento so we need to convert the sprite's native offsets
    BentoSetOrigin(sprite_get_xoffset(sprite) / sprite_get_width(sprite),
                   sprite_get_yoffset(sprite) / sprite_get_height(sprite));
    
    eventDraw = function()
    {
        //Use the convenience function to draw the sprite stretched across the element
        BentoDrawSprite(sprite);
    }
}