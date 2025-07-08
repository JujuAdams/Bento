// Feather disable all

function TestAnimations()
{
    structTest = new BentoConstrSprite(sBentoMaskRectangle, BentoGetRoot());
    with(structTest)
    {
        BentoSetOffset(100, 100);
        BentoLayoutList(BENTO_AXIS_Y, fa_left, fa_top);
        BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        new BentoConstrSprite(sBentoMaskRectangle);
        new BentoConstrSprite(sBentoMaskRectangle);
        
        //var _text = new BentoConstrText("Hello World", undefined, fa_center);
        //BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, _text);
        
        //var _text = BentoCreate(oBentoText, { text: "Hello World", hAlign: fa_center });
        //BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, _text);
        //
        //new ExampleConstrButton(undefined, "Test");
        //new ExampleConstrButton(undefined, "Test");
        //
        //var _grid = new BentoConstrSprite(sBentoMaskRectangle);
        //with(_grid)
        //{
        //    BentoLayoutGrid(6, 2);
        //    BentoLayoutSetFromJSON({
        //        size:     [600, 200],
        //        resize:   [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
        //        padding:  [10, 10, 10, 10],
        //        gutter:   [10, 10],
        //    });
        //    
        //    repeat(10)
        //    {
        //        with(new ExampleConstrButton())
        //        {
        //            BentoLayoutSetAlignSelf(0.5, 0.5);
        //        }
        //    }
        //}
    }
}