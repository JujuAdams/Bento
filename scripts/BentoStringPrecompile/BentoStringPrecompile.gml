/// Precompiles the string as BentoScript but does not execute it.
/// 
/// Using this function speeds up the first-time execution of a string.

function BentoStringPrecompile(_string)
{
    if (is_array(_string))
    {
        var _array = _string;
        if (array_length(_array) > BENTO_MAX_CACHED_STRINGS)
        {
            __BentoTrace("Warning! Array length ");
        }
        
        var _i = 0;
        repeat(array_length(_array))
        {
            BentoStringPrecompile(_array[_i]);
            ++_i;
        }
        
        return;
    }
    
    __BentoStringEnsure(_string);
}