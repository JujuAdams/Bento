enum BENTO_FLOW_DIRECTION
{
    X,
    Y
}

enum BENTO_OVERFLOW
{
    IGNORE,
    CLIP,
    SCROLL
}

enum BENTO_EVENT
{
    STEP,
    DRAW,
    __SIZE
}

global.__bentoConstants = {};

#macro __BENTO_VERSION  "0.0.0"
#macro __BENTO_DATE     "2021-03-20"

__BentoTrace("Welcome to Bento by @jujuadams! This is version ", __BENTO_VERSION, ", ", __BENTO_DATE);

/// @param [value...]
function __BentoTrace()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }

    show_debug_message("Bento: " + _string);

    return _string;
}

/// @param [value...]
function __BentoError()
{
    var _string = "";
    
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_error("Bento:\n" + _string + "\n ", false);
    
    return _string;
}

function __BentoResolveValue(_value)
{
    return _value;
}