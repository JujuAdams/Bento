/// Generates a random UUID using the UUIDv4 standard.
/// 
/// This function is used internally to provisionally name layers. You may also want to use it
/// for other purposes in your own code.

function BentoRandomUUID(_hyphenate = false)
{
    //As per https://www.cryptosys.net/pki/uuid-rfc4122.html (though without the hyphens)
    var _UUID = md5_string_unicode(string(current_time) + string(date_current_datetime()) + string(__BentoXORShift32Random(1000000)));
    _UUID = string_set_byte_at(_UUID, 13, ord("4"));
    _UUID = string_set_byte_at(_UUID, 17, ord(__BentoXORShift32Choose("8", "9", "a", "b")));
    
    if (_hyphenate)
    {
        _UUID = string_copy(_UUID, 1, 8) + "-" + string_copy(_UUID, 9, 4) + "-" + string_copy(_UUID, 13, 4) + "-" + string_copy(_UUID, 17, 4) + "-" + string_copy(_UUID, 21, 12);
    }
    
    return _UUID;
}