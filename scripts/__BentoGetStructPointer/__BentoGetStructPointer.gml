/// @param struct

function __BentoGetStructPointer(_struct)
{
    return string_delete(string(ptr(_struct)), 1, 8);
}