// Feather disable all

function TestShrinkAndExpand()
{
    with(BentoCreate(oExampleListWithScroll, undefined, BentoGetRoot()))
    {
        image_blend = c_navy;
        
        BentoLayoutSetList(BENTO_AXIS_X, fa_left, fa_top);
        BentoLayoutSetSize(600, 200);
        BentoLayoutSetResizeType(BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK);
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
            BentoLayoutSetResizeType(BENTO_RESIZE_EXPAND, BENTO_RESIZE_EXPAND);
        }
        
        with(BentoCreate(oBentoSprite))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(50, 100);
            BentoLayoutSetResizeType(BENTO_RESIZE_EXPAND, BENTO_RESIZE_EXPAND);
        }
        
        with(BentoCreate(oBentoSprite))
        {
            image_blend = c_blue;
            BentoLayoutSetSize(100, 100);
        }
    }
}