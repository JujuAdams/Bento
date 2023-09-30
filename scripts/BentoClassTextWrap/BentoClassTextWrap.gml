/// A wrapped text rendering class. The size of the UI element will NOT automatically resize based
/// on the text itself. If you want to resize the UI element to fit around the text, call the
/// Trim() method. Available in BentoScript using the BentoText builder.
/// 
/// Available variables (in addition to shared UI variables) are:
/// 
/// | Name      | Datatype | Purpose                                                                              |
/// |-----------|----------|--------------------------------------------------------------------------------------|
/// | label     | string   | Text to draw                                                                         |
/// | margin    | number   | Additional space to put around the text when calculating the bounding box            |
/// | font      | string   | Name of the font to use                                                              |
/// | color     | RGB      | Colour to use when drawing the text                                                  |
/// | scale     | number   | Scaling factor. A value of 1 is no change                                            |
/// | alpha     | number   | Alpha blending value                                                                 |
/// | hAlign    | string   | "left," "center", or "right". Note that the bounding box calcs are based on "centre" |
/// | vAlign    | string   | "top", "middle", or "bottom". Note that the bounding box calcs are based on "middle" |
/// 
/// Instances of BentoTextWrap also have the following methods:
/// 
/// .Trim()
/// 
/// Returns: <undefined>
/// 
/// | Argument Name | Datatype | Purpose |
/// |---------------|----------|---------|
/// | None          |          |         |
/// 
/// Resizes the UI element to match the size of the rendered text.

BentoAddBoxType("BentoTextWrap", BentoClassTextWrap, false);
function BentoClassTextWrap() : BentoClassText() constructor
{
    __wrap = true;
}