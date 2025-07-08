// Feather disable all

function TestStructs()
{
    structTest = new BentoConstrSprite(sBentoMaskRectangle, BentoGetRoot());
    with(structTest)
    {
        BentoLayoutSetAlignSelf(0.5, 0.5);
        BentoLayoutSetList(BENTO_AXIS_Y, fa_left, fa_top);
        BentoLayoutSetResizeType(BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        var _text = new BentoConstrText("Hello World", undefined, fa_center);
        BentoLayoutSetResizeType(BENTO_RESIZE_EXPAND, undefined, _text);
        
        var _text = BentoCreate(oBentoText, { text: "Hello World", hAlign: fa_center });
        BentoLayoutSetResizeType(BENTO_RESIZE_EXPAND, undefined, _text);
        
        new ExampleConstrButton(undefined, "Test");
        new ExampleConstrButton(undefined, "Test");
        
        var _grid = new BentoConstrSprite(sBentoMaskRectangle);
        with(_grid)
        {
            BentoLayoutSetGrid(6, 2);
            BentoLayoutSetFromJSON({
                size:    [600, 200],
                resize:  [BENTO_RESIZE_SHRINK, BENTO_RESIZE_SHRINK],
                padding: [10, 10, 10, 10],
                gutter:  [10, 10],
            });
            
            repeat(10)
            {
                with(new ExampleConstrButton())
                {
                    BentoLayoutSetAlignSelf(0.5, 0.5);
                }
            }
        }
    }
}