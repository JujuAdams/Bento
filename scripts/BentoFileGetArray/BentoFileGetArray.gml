/// Returns an array of the paths for every external UI file that had previously been loaded with
/// BentoFileLoad() or executed with BentoFileExecute().

function BentoFileGetArray()
{
    static _sourceArray = __BentoGlobal().__fileArray;
    
    var _size = array_length(_sourceArray);
    var _array = array_create(_size);
    
    var _i = 0;
    repeat(_size)
    {
        _array[@ _i] = _sourceArray[_i].__path;
        ++_i;
    }
    
    return _array;
}