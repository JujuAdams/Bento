// Feather disable all

/// @param value

function __ScribblejrError()
{
    var _string = " \nScribblejr " + string(SCRIBBLEJR_VERSION) + ":\n";
    
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    SCRIBBLEJR_SHOW_ERROR(_string + "\n ", true);
}