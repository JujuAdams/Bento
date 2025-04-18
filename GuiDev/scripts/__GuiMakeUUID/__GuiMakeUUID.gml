// Feather disable all

function __GuiMakeUUID(_id, _object, _globalCount)
{
    var _globalCountString = string(_globalCount);
    repeat(4 - string_length(_globalCountString))
    {
        _globalCountString = "0" + _globalCountString;
    }
    
    return $"{_globalCountString}_{object_get_name(_object)}";
}