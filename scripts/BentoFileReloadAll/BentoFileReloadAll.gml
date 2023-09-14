/// Forcibly reloads every external UI file that had previously been loaded with BentoFileLoad()
/// or executed with BentoFileExecute().

function BentoFileReloadAll()
{
    static _array = __BentoGlobal().__fileArray;
    
    var _i = 0;
    repeat(array_length(_array))
    {
        _array[_i].__Load(true);
        ++_i;
    }
}