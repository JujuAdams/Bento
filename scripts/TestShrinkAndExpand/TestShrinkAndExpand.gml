// Feather disable all

function TestDeflateAndInflate()
{
    with(BentoCreate(oBentoExScrollingList, undefined, BentoLayerGetRoot()))
    {
        image_blend = c_navy;
        
        BentoLayoutList(BENTO_AXIS_X, 0, 0);
        BentoLayoutSetSize(600, 200);
        BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
        BentoLayoutSetPaddingExt(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        with(BentoCreate(oBentoExSprite))
        {
            image_blend = c_red;
            BentoLayoutSetSize(100, 100);
        }
        
        with(BentoCreate(oBentoExSprite))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(100, 50);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
        
        with(BentoCreate(oBentoExSprite))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(50, 100);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
        
        with(BentoCreate(oBentoExSprite))
        {
            image_blend = c_blue;
            BentoLayoutSetSize(100, 100);
        }
    }
}