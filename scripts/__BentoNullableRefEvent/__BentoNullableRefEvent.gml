function __BentoNullableRefEvent(_ref, _eventType, _data)
{
    var _struct = __BentoNullableRefResolve(_ref);
    if (_struct != undefined) _struct.__EventGet(_eventType).__Call(_struct, _data);
}