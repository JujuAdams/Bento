/// Replaces a box with the result of executing a BentoScript file.
/// 
/// @param identifier
/// @param [path]

function BentoReplace(_identifier, _file)
{
    BentoBoxFind(_identifier).ReplaceFromFile(_file);
}