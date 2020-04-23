//Elements in Bento's DOM are created by calling scripts
//Elements are structs (a.k.a. light-weight objects) with lots of data nested inside them
document = bento_box_region(30, 30, room_width-30, room_height-30);
//We can access variables attached to this element using dot notations
document.style.margin = 10;
document.style.fill.color = c_black;
document.style.fill.alpha = 0.7;
document.style.interactive = false;

//We use the add_at() method to add child elements at a fixed position
//Here, we're adding a named child called "clip_window" at position {0,0} relative to the parent
//This element can later be referenced with "document.clip_window"
//Because <document> has its margin set to 10px, <document.clip_window> will appear at {40,40} in worldspace
var _rectangle = bento_box(160, 210);
document.add_at(0, 0, _rectangle, "clip_window");

//We can use with() statements to make assigning lots of variables easier
with(document.clip_window.style)
{
    clip       = true;
    fill.color = c_white;
    fill.alpha = 0.8;
}



//Style templates are structs, stored in global scope, and are referenced by string
//bento_style_template() can be used to both create and get a style template
with(bento_style_template("nineslice template"))
{
    sprite.nineslice.l = 8;
    sprite.nineslice.t = 8;
    sprite.nineslice.r = 8;
    sprite.nineslice.b = 8;
}

with(document.add(bento_nineslice(s9SliceTest, 0, 300, 200, "nineslice template"), "nineslice1"))
{
    anchor_right( root, "center", 0, -20);
    anchor_bottom(root, "bottom", 0,   0);
}

with(document.add(bento_nineslice(s9SliceTest, 0, 300, 200, "nineslice template"), "nineslice2"))
{
    anchor_left(  root, "center", 0, 20);
    anchor_bottom(root, "bottom", 0,  0);
}



with(bento_style_template("clip window text"))
{
    text.color = c_black;
}

//We can use the optional argument of bento_text() to specify a style template
var _text = bento_text("Clipping Window", "clip window text");
document.clip_window.add_at(3, 0, _text);

//Because we set <document.clip_window> to clip, any child content that exceeds the limits of the parent element will be visually clipped
var _i = 0;
repeat(20)
{
    var _string = 5*("text " + string(_i) + " ");
    document.clip_window.add_at(3, 20 + _i*20, bento_text(_string, "clip window text"));
    ++_i;
}

with(document.add(bento_text("This text is a button."), "button1"))
{
    //Here we're going to some manual anchoring
    //We're going to align this element (a text button) to the top right of the clip window
    //Note that we're using <root> instead of <document> here. This is because <button1> can't read variable in instance scope
    anchor_left(root.clip_window, "right", 20, 0);
    anchor_top( root.clip_window, "top"  ,  0, 0);
    
    //Button behaviour is enabled by setting functions
    callbacks.mouse_released = function()
    {
        //This function will display the button's long name when clicked
        show_message(properties.long_name);
    }
}

with(document.add(bento_box(200, 60), "button2"))
{
    anchor_left(root.button1, "left"  ,  0, 0);
    anchor_top( root.button1, "bottom", 40, 0);
}

with(document.button2.add(bento_text("Button Event"), "display_text"))
{
    anchor_left(root.button2, "center", 0, "-50%");
    anchor_top( root.button2, "middle", 0, "-50%");
    
    with(style)
    {
        text.color  = c_black;
        text.halign = fa_center; //Text can be horizontal/vertically aligned as usual
        text.valign = fa_middle;
        interactive = false; //Elements can be set to non-interactive to stop them from eating mouse input
    }
    
    callbacks.mouse_event = function(_event) //Bento also offers an event-driven approach for buttons too
    {
        if ((_event != "over") || !properties.mouse.state)
        {
            display_text.properties.text = "Button Event\n" + _event;
        }
    
        if (_event == "released")
        {
            show_message(root.children);
        }
    }
}