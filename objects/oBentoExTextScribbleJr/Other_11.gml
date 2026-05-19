/// @desc Draw

//Use the text alignment to figure out which side of the element to draw text on
if (hAlign == fa_left)
{
    var _x = bentoLeft;
}
else if (hAlign = fa_right)
{
    var _x = bentoRight;
}
else
{
    //Default horizontal alignment to center
    var _x = 0.5*(bentoLeft + bentoRight);
}

if (vAlign == fa_top)
{
    var _y = bentoTop;
}
else if (vAlign = fa_bottom)
{
    var _y = bentoBottom;
}
else
{
    //Default horizontal alignment to middle
    var _y = 0.5*(bentoTop + bentoBottom);
}

ScribblejrFitExt(text, hAlign, vAlign, font, undefined, bentoWidth, bentoHeight).Draw(_x, _y, image_blend, image_alpha);