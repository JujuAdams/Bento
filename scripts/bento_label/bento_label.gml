/// @param parent
/// @param string
/// @param spacing
/// @param [templateName]

function bento_label()
{
    var _parent  = argument[0];
    var _string  = argument[1];
    var _spacing = argument[2];
    var _style   = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : undefined;
    
    with(bento_text(_string, _style))
    {
        anchor_left(_parent, "right", _spacing, 0);
        anchor_top(_parent, "center", 0, "-50%");
        
        return self;
    }
}