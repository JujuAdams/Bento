/// Executes the given string as BentoScript.
/// 
/// The first time a string is executed, Bento will need to compile the string, This takes quite
/// a lot of time. In perform-sensitive scenarios you'll want to use BentoStringPrecompile() to
/// pay the up-front cost of compilation to a place in gameplay where compilation time isn't an
/// issue, such as a loading screen.

function BentoStringExecute(_string)
{
    return __BentoStringEnsure(_string).__Execute();
}