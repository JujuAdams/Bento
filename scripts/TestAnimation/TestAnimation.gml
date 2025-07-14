// Feather disable all

function TestAnimations()
{
    structTest = new BentoConstrSprite(sBentoMaskRectangle, BentoGetRoot());
    with(structTest)
    {
        BentoSetOffset(100, 100);
        BentoLayoutList(BENTO_AXIS_Y, 0, 0);
        BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        with(new ExampleConstrButton(function()
        {
            BentoLayoutSetBypass(true);
            BentoAnimPlayBuildOut(60, 0, 40, 0, 1, 1, 0);
            
            //BentoTransformSetScale(2, 2);
            //BentoAnimPlayBasic(30, 0, 0, 0, 1, 1);
        }))
        {
            BentoAnimPlayBuildIn(60, 0, -40, 0, 1, 1, 0);
        }
    }
}