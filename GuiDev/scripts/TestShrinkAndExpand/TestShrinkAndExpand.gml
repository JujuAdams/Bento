// Feather disable all

function TestDeflateAndInflate()
{
    with(BentoCreate(oExampleListWithScroll, undefined, BentoGetRoot()))
    {
        image_blend = c_navy;
        
        BentoLayoutList(BENTO_AXIS_X, fa_left, fa_top);
        BentoLayoutSetSize(600, 200);
        BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        with(BentoCreate(oBentoSprite))
        {
            image_blend = c_red;
            BentoLayoutSetSize(100, 100);
        }
        
        with(BentoCreate(oBentoSprite))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(100, 50);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
        
        with(BentoCreate(oBentoSprite))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(50, 100);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
        }
        
        with(BentoCreate(oBentoSprite))
        {
            image_blend = c_blue;
            BentoLayoutSetSize(100, 100);
        }
    }
}