/// An invisible rectangle used for organising layouts. Available in BentoScript using the BentoBox
/// builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name | Datatype | Purpose |
/// |------|----------|---------|
/// | None |          |         |

BentoAddBoxType("BentoBox", BentoClassBox, false);
function BentoClassBox() : BentoClassShared() constructor
{
    Set("visible", false);
}