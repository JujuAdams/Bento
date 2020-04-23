/// The default style for all elements when they're created

function __bento_style_default() constructor
{
    clip           = false;
    clip_new_frame = false;
    interactive    = true;
    layout         = "none"; //Can be "none", "flexbox", or "grid"
    
    fill = {
        color : c_white,
        alpha : 1.0,
    };
    
    outline = {
        color : c_white,
        alpha : 0.0,
    };
    
    text = {
        font   : -1,
        halign : fa_left,
        valign : fa_top,
        color  : c_white,
        alpha  : 1.0,
    };
    
    sprite = {
        index : undefined,
        image : -1,
        color : c_white,
        alpha : 1.0,
        nineslice : false,
        nineslice_border : {
            l : 0,
            t : 0,
            r : 0,
            b : 0,
        },
    };
    
    surface = {
        index : undefined,
        color : c_white,
        alpha : 1.0,
    };
    
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
        direction       : "rows", //TODO
        columns         : undefined,
        rows            : undefined,
        column_gap      : 0,
        row_gap         : 0,
        content_justify : "start",
        content_align   : "start",
        element_justify : "start",
        element_align   : "start",
    };
    
    flexbox = {
        direction     : "rows", //TODO
        content_align : "start",
        line_justify  : "start",
        line_align    : "start",
    };
}