// Feather disable all

function TestStructs()
{
    structTest = new BentoConstrSprite(undefined, BentoGetRoot());
    with(structTest)
    {
        BentoLayoutSetList(GUI_AXIS_Y, fa_left, fa_top);
        BentoLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
        BentoLayoutSetPadding(10, 10, 10, 10);
        BentoLayoutSetGutter(10, 10);
        
        var _text = new BentoConstrText("Hello World", undefined, fa_center);
        BentoLayoutSetResizeType(GUI_RESIZE_EXPAND, undefined, _text);
        
        var _text = BentoCreateObject(oBentoLibText, { text: "Hello World", hAlign: fa_center });
        BentoLayoutSetResizeType(GUI_RESIZE_EXPAND, undefined, _text);
        
        new ExampleConstrButton(undefined, "Test");
        new ExampleConstrButton(undefined, "Test");
        
        var _grid = new BentoConstrSprite(sBentoMaskRectangle);
        with(_grid)
        {
            BentoLayoutSetGrid();
            BentoLayoutSetFromJSON({
                gridSize: [6, 2],
                size:     [600, 200],
                resize:   [GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK],
                padding:  [10, 10, 10, 10],
                gutter:   [10, 10],
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