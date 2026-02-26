// Feather disable all

function TestStructs()
{
    structTest = new BentoConstrSprite(sBentoMaskRectangle, BentoGetRoot());
    with(structTest)
    {
        BentoLayoutList(BENTO_AXIS_Y, 0, 0);
        BentoLayoutSetAnchor(0.5, 0.5);
        BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        var _text = new BentoConstrText("Hello World", undefined, fa_center);
        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, _text);
        
        var _text = BentoCreate(oBentoText, { text: "Hello World", hAlign: fa_center });
        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined, _text);
        
        new BentoExButtonConstr(undefined, "Test");
        new BentoExButtonConstr(undefined, "Test");
        
        var _grid = new BentoConstrSprite(sBentoMaskRectangle);
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
                with(new BentoExButtonConstr())
                {
                    BentoLayoutSetAnchor(0.5, 0.5);
                }
            }
        }
    }
}