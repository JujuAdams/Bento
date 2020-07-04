/// @function __bento_call_method(function)
/// @param function
/// @param [argument]
function __bento_call_method()
{
    var _function = argument[0];
    var _argument = (argument_count > 1)? argument[1] : undefined;
    
    var _self = self;
    
    if (_function == undefined)
    {
        return undefined;
    }
    else if (is_method(_function))
    {
        var _method_self = method_get_self(_function);
        if ((_method_self != _self) && (_method_self != undefined)) _function = method(_self, _function);
        return _function(_argument);
    }
    else
    {
        return script_execute(_function, _argument);
    }
}