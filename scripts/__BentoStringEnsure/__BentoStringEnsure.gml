function __BentoStringEnsure(_string)
{
    static _fileDict = __BentoGlobal().__stringDict;
    
    var _struct = _fileDict[$ _string];
    return is_struct(_struct)? _struct : new __BentoClassString(_string);
}