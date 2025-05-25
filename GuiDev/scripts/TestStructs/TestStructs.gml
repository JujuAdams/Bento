// Feather disable all

function TestStructs()
{
    structTest = new GuiConstrList(GuiGetRoot());
    with(structTest)
    {
        GuiLayoutSetResizeType(GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK);
        GuiLayoutSetPadding(10, 10, 10, 10);
        GuiLayoutSetGutter(10, 10);
        GuiLayoutSetListAxis(GUI_AXIS_Y);
        
        var _text = new GuiConstrText("Hello World", undefined, fa_center);
        GuiLayoutSetResizeType(GUI_RESIZE_GROW, undefined, _text);
        
        var _text = GuiCreateObject(oGuiLibText, { text: "Hello World", hAlign: fa_center });
        GuiLayoutSetResizeType(GUI_RESIZE_GROW, undefined, _text);
        
        new GuiConstrRect();
        new GuiConstrRect();
        
        var _grid = new GuiConstrGrid();
        with(_grid)
        {
            GuiLayoutSetFromJSON({
                gridSize: [6, 2],
                size:     [600, 200],
                resize:   [GUI_RESIZE_SHRINK, GUI_RESIZE_SHRINK],
                padding:  [10, 10, 10, 10],
                gutter:   [10, 10],
            });
            
            repeat(10)
            {
                with(new GuiConstrRect())
                {
                    GuiLayoutSetAlignSelf(0.5, 0.5);
                }
            }
        }
    }
}