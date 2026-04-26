BentoSetSkin("thick frame", function()
{
    sprite_index = sBentoExFrame;
    
    if (image_blend == c_white)
    {
        image_blend = BENTO_EXAMPLE_YELLOW;
    }
    
    BentoLayoutSetPaddingExt(10, 10, 10, 10);
    
    if (BentoClipGetEnabled())
    {
        BentoClipSetPadding(4, 4, 4, 4);
    }
});