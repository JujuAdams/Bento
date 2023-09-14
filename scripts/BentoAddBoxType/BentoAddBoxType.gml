/// Adds a new type of UI box for use with the library.
/// 
/// @param name
/// @param constructorFunction
/// @param [overwrite=true]

function BentoAddBoxType(_name, _constructor, _overwrite = true)
{
    static _bentoScriptEnv = __BentoGlobal().__bentoScriptEnv;
    
    var _oldConstructor = _bentoScriptEnv.interface[$ _name];
    if (_oldConstructor != undefined)
    {
        var _oldConstructorName = is_numeric(_oldConstructor)? (script_exists(_oldConstructor)? script_get_name(_oldConstructor) : ("<unknown script " + string(_oldConstructor) + ">")) : string(_oldConstructor);
        
        var _newConstructor = _constructor;
        var _newConstructorName = is_numeric(_newConstructor)? (script_exists(_newConstructor)? script_get_name(_newConstructor) : ("<unknown script " + string(_newConstructor) + ">")) : string(_newConstructor);
        
        if (_overwrite)
        {
            __BentoTrace("Warning! Overwriting old box type \"", _name, "\" constructor ", _oldConstructorName, " with constructor ", _newConstructorName);
        }
        else
        {
            __BentoTrace("Warning! Cannot overwrite old box type \"", _name, "\" constructor ", _oldConstructorName, " with constructor ", _newConstructorName, ", overwrite permission denied");
            return;
        }
    }
    
    _bentoScriptEnv.interface.exposeMethod(_name, method({ const: _constructor }, function()
    {
        if (is_method(const) || (is_numeric(const) && script_exists(const)))
        {        
            var _box = new const();
        }
        else
        {
            __BentoError("Box constructor \"", const, "\" not recognised");
        }
        
        BentoOpen(_box);
        return method(undefined, BentoClose);
    }));
}