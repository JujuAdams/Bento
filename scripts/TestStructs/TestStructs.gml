// Feather disable all

function TestStructs()
{
    structTest = new BentoConstrExSprite(sBentoMaskRectangle, BentoGetRoot());
    with(structTest)
    {
        BentoLayoutList(BENTO_AXIS_Y, 0, 0);
        BentoLayoutSetAnchor(0.5, 0.5);
        BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        var _text = new BentoConstrExText("Hello World", undefined, fa_center);
        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, _text);
        
        var _text = BentoCreate(oBentoExText, { text: "Hello World", hAlign: fa_center });
        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, _text);
        
        new BentoConstrExButton(undefined, "Test");
        new BentoConstrExButton(undefined, "Test");
        
        var _grid = new BentoConstrExSprite(sBentoMaskRectangle);
        with(_grid)
        {
            BentoLayoutGrid(6, 2);
            BentoLayoutSetFromJSON({
                size:    [600, 200],
                resize:  [BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE],
                padding: [10, 10, 10, 10],
                gutter:  [10, 10],
            });
            
            repeat(10)
            {
                with(new BentoConstrExButton())
                {
                    BentoLayoutSetAnchor(0.5, 0.5);
                }
            }
        }
    }
}