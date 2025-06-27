// Feather disable all

function TestShrinkAndExpand()
{
    with(BentoCreateObject(oExampleListWithScroll, undefined, BentoGetRoot()))
    {
        image_blend = c_navy;
        
        BentoLayoutSetList(GUI_AXIS_X, fa_left, fa_top);
        BentoLayoutSetSize(600, 200);
        BentoLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        with(BentoCreateObject(oBentoLibSprite))
        {
            image_blend = c_red;
            BentoLayoutSetSize(100, 100);
        }
        
        with(BentoCreateObject(oBentoLibSprite))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(100, 50);
            BentoLayoutSetResizeType(GUI_RESIZE_EXPAND, GUI_RESIZE_EXPAND);
        }
        
        with(BentoCreateObject(oBentoLibSprite))
        {
            image_blend = c_yellow;
            BentoLayoutSetSize(50, 100);
            BentoLayoutSetResizeType(GUI_RESIZE_EXPAND, GUI_RESIZE_EXPAND);
        }
        
        with(BentoCreateObject(oBentoLibSprite))
        {
            image_blend = c_blue;
            BentoLayoutSetSize(100, 100);
        }
    }
}