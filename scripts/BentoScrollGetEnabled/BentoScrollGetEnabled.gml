// Feather disable all

/// Returns a struct containing three variables (`.horizontal` `.vertical` `.enabled`) that
/// indicate whether scrolling is enabled in the associated axes.
/// 
/// @param [element=self]

function BentoScrollGetEnabled(_element = self)
{
    static _result = {
        either:     false,
        horizontal: false,
        vertical:   false,
    };
    
    with(_result)
    {
        if (BentoExists(_element))
        {
            horizontal = _element.BENTO_VARS.__scrollHori;
            vertical   = _element.BENTO_VARS.__scrollVert;
            either     = horizontal || vertical;
        }
        else
        {
            horizontal = false;
            vertical   = false;
            either     = false;
        }
    }
    
    return _result;
}