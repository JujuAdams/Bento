//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoVarEnsure("fill", true);

if (image_blend == c_white)
{
    image_blend = BENTO_EXAMPLE_YELLOW;
}