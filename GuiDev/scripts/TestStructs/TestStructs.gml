// Feather disable all

function TestStructs()
{
    structTest = new GuiConstrRect(GuiGetRoot());
    with(structTest)
    {
        GuiLayoutSetList(GUI_AXIS_Y, fa_left, fa_top);
        GuiLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
        GuiLayoutSetPadding(10, 10, 10, 10);
        GuiLayoutSetGutter(10, 10);
        
        var _text = new GuiConstrText("Hello World", undefined, fa_center);
        GuiLayoutSetResizeType(GUI_RESIZE_GROW, undefined, _text);
        
        var _text = GuiCreateObject(oGuiLibText, { text: "Hello World", hAlign: fa_center });
        GuiLayoutSetResizeType(GUI_RESIZE_GROW, undefined, _text);
        
        new ExampleConstrButton(undefined, "Test");
        new ExampleConstrButton(undefined, "Test");
        
        var _grid = new GuiConstrRect();
        with(_grid)
        {
            GuiLayoutSetGrid();
            GuiLayoutSetFromJSON({
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
                    GuiLayoutSetAlignSelf(0.5, 0.5);
                }
            }
        }
    }
}