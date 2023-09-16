/// Creates a Bento host.
/// 
///   N.B. You'll probably never need to use this function. It exists for use with complex setups
///        where multiple users might need separate interfaces that can be used simultaneously.
/// 
/// @param [name=UUIDv4]

function BentoHostCreate(_name = undefined)
{
    return new __BentoClassHost(_name);
}