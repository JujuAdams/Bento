function __BentoTrace()
{
    var _string = "";
    
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    //Use some indirection to prevent compile failures when setting BENTO_TRACE to <undefined>
    var _BENTO_TRACE = BENTO_TRACE;
    if (_BENTO_TRACE != undefined) _BENTO_TRACE(_string);
}