// Feather disable all

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

//Organize children in a list in the y-axis. Ensure that children are centre-aligned in the
//x-axis.
BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);

//Reduce the size of the list element (this instance) to tightly fit the children. If there are
//no children then the list will have zero size.
BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);