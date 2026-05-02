/// @desc Draw Hover

if (BentoGetClickable())
{
    BentoDrawSpriteAround(10, sBentoExHighlight, undefined, c_black, BENTO_EXAMPLE_HIGHLIGHT_SHADOW_ALPHA, undefined, BENTO_EXAMPLE_HIGHLIGHT_SHADOW_OFFSET, BENTO_EXAMPLE_HIGHLIGHT_SHADOW_OFFSET);
    BentoDrawSpriteAround(10, sBentoExHighlight, undefined, BENTO_EXAMPLE_RED);
}