/// @desc Draw Hover

if (BentoGetClickable())
{
    BentoDrawSpriteAround(10, sBentoExHighlight, undefined, c_black, 0.2, un, 3, 3);
    BentoDrawSpriteAround(10, sBentoExHighlight, undefined, BENTO_EXAMPLE_RED);
}