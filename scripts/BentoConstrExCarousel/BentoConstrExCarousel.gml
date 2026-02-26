// Feather disable all

/// @param reference
/// @param optionArray
/// @param [title]
/// @param [func]
/// @param [parent=self]

function BentoConstrExCarousel(_reference, _optionArray = [], _text = "", _func = undefined, _parent = other) : BentoConstrAncestor(_parent) constructor
{
    reference   = _reference;
    optionArray = _optionArray;
    text        = _text;
    func        = _func ?? function() {};
    
    var _width  = string_width(text);
    var _height = string_height(text);
    
    var _optionWidth  = 0;
    var _optionHeight = 0;
    
    var _i = 0;
    repeat(array_length(optionArray))
    {
        _optionWidth  = max(_optionWidth,  string_width(optionArray[_i]) + 40);
        _optionHeight = max(_optionHeight, string_height(optionArray[0]));
        ++_i;
    }
    
    BentoLayoutSetSize(max(_width, _optionWidth) + 30, _height + _optionHeight + 10);
    
    BentoSetButton(BENTO_BUTTON_ALWAYS);
    
    // Disables raycasting in particular axes. This only applies to directional input where raycasting
    // is used to work out which element to jump to when pushing in a particular direction. This does
    // not apply to navigation links created with `BentoLink*()` functions. We disable horizontal
    // raycasting so that it doesn't interfere with scrolling through options.
    BentoSetRaycastEnable(false, true);
    
    
    
    
    
    eventStep = function()
    {
        var _funcGetOptionIndex = function()
        {
            var _option = BentoRefGet(reference, undefined);
            var _optionIndex = array_get_index(optionArray, _option);
            return max(_optionIndex, 0);
        }
        
        var _length = array_length(optionArray);
        if (_length > 0)
        {
            if (BentoUsingPointer())
            {
                // Detect clicks to scroll through the option array.
                if (BentoPrimaryGetClick())
                {
                    var _delta = sign(BentoCursorGetX() - 0.5*(bentoLeft + bentoRight));
                    if (_delta == 0) _delta = 1;
                    
                    var _optionIndex = (_funcGetOptionIndex() + _delta + _length) mod _length;
                    
                    var _option = optionArray[_optionIndex];
                    BentoRefSet(reference, _option);
                    func(_option); //Execute the callback
                }
            }
            else if (BentoUsingDirectional())
            {
                // Detect directional input to scroll throught the option array.
                if (BentoCursorGetHover() && (BentoCursorGetDX() != 0))
                {
                    var _optionIndex = (_funcGetOptionIndex() + sign(BentoCursorGetDX()) + _length) mod _length;
                    
                    var _option = optionArray[_optionIndex];
                    BentoRefSet(reference, _option);
                    func(_option); //Execute the callback
                }
            }
        }
    }
    
    eventDraw = function()
    {
        var _x = 0.5*(bentoLeft + bentoRight);
        var _y = 0.5*(bentoTop + bentoBottom);
        
        BentoDrawSprite(sBentoMaskRectangle);
        
        if (BentoCursorGetHover())
        {
            gpu_set_fog(true, c_white, 0, 0);
            BentoDrawSprite(sBentoMaskRectangle, undefined, undefined, 0.3*image_alpha);
            gpu_set_fog(false, c_fuchsia, 0, 0);
        }
        
        if (text != "")
        {
            draw_set_halign(fa_center);
            draw_text(_x, bentoTop + 5, text);
            draw_set_halign(fa_left);
        }
        
        if (array_length(optionArray) > 0)
        {
            draw_set_halign(fa_center);
            draw_set_valign(fa_bottom);
            draw_text(_x, bentoBottom - 5, BentoRefIsAlive(reference)? string(BentoRefGet(reference, "")) : optionArray[0]);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
        
        draw_triangle(bentoLeft+5, _y, bentoLeft+15, _y-5, bentoLeft+15, _y+5, false); 
        draw_triangle(bentoRight-5, _y, bentoRight-15, _y-5, bentoRight-15, _y+5, false);
    }
}