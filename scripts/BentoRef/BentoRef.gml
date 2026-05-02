// Feather disable all

/// Creates a reference to a variable. This reference can be used to get/set a variable later. THis
/// is useful for linking UI to variables. References are made of two parts: a struct and a
/// variable name. The variable name should be a string. You may use an instance or `global` as the
/// "struct" if you would like to target instance variables or global variables.
/// 
/// Bento reference are "weak" references that don't keep the target struct in scope. A reference
/// may fall out of scope unpredictably so all Bento reference functions have fallback behaviours
/// in case a reference becomes invalid.
/// 
/// @param struct
/// @param variableName

function BentoRef(_struct, _variableName)
{
    return new __BentoClassRef(_struct, _variableName);
}