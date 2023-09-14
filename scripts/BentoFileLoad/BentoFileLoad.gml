/// Loads an external UI file. This isn't strictly necessary, a UI file is automatically loaded
/// when executed, but calling this function when a game boots up improves performance when
/// BentoFileExecute() is called later during gameplay.
/// 
/// This function can be given an array to load multiple files.
/// 
/// @param pathOrArray

function BentoFileLoad(_path)
{
    if (is_array(_path))
    {
        var _array = _path;
        
        var _i = 0;
        repeat(array_length(_array))
        {
            BentoFileLoad(_array[_i]);
            ++_i;
        }
        
        return;
    }
    
    return __BentoFileEnsure(_path).__Load(true);
}