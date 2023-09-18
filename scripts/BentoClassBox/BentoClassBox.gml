/// The most basic sort of container - an invisible rectangle.
/// Useful for subdividing UI layouts or creating spacers.
/// 
/// This box has no variables, callbacks, or methods beyond BentoClassShared().

BentoAddBoxType("BentoBox", BentoClassBox, false);
function BentoClassBox() : BentoClassShared() constructor
{
    Set("visible", false);
}