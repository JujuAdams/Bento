/// Defines the default style for all elements when they're created
/// This script is called on boot by bento_style_template()

function __bento_style_template_default()
{
    with(bento_style_template("default"))
    {
        clip           = false;
        clip_new_frame = false;
        interactive    = false;
        layout         = "none"; //Can be "none", "flexbox", or "grid"
        
        margin = {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        };
        
        padding = {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        };
        
        grid = {
            columns        : undefined,
            rows           : undefined,
            column_gap     : 0,
            row_gap        : 0,
            direction      : "rows",
            content_halign : "left",
            content_valign : "top",
            element_halign : "left",
            element_valign : "top",
        };
        
        flexbox = {
            grow           : 0,
            direction      : "rows",
            content_halign : "left",
            content_valign : "top",
            line_halign    : "left",
            line_valign    : "top",
        };
    }
}