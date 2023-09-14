/// The most basic sort of container - an invisible rectangle.
/// Useful for subdividing UI layouts or creating spacers.
/// 
/// In addition to BentoClassShared() variables, public variables are:
///   borderColor
///   borderAlpha
///   fillColor
///   fillAlpha
/// 
/// This box has no callbacks or methods beyond BentoClassShared().

BentoAddBoxType("BentoBox", BentoClassBox, false);
function BentoClassBox() : BentoClassRectangle() constructor
{
    Set("visible", false);
}