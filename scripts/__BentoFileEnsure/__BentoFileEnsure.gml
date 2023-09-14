function __BentoFileEnsure(_path)
{
    static _fileDict = __BentoGlobal().__fileDict;
    
    var _struct = _fileDict[$ _path];
    return is_struct(_struct)? _struct : new __BentoClassFile(_path);
}