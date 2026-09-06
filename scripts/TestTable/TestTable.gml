function TestTable()
{
    var _padding = 20;
    
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreateBlank(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPadding(_padding);
            BentoLayoutSetGutter(_padding, _padding);
            BentoLayoutSetResize(BENTO_RESIZE_NORMAL, BENTO_RESIZE_NORMAL);
            BentoLayoutTable(2, 0.5, infinity);
            BentoLayoutSetTableColumn(0, 0.5, infinity);
            
            BentoCreate(oBentoExText, { text: "Label" });
            BentoCreate(oBentoExButton, { text: "Button 1" });
            
            BentoCreate(oBentoExText, { text: "Label 2 Label 2 Label 2" });
            BentoCreateBlank();
            
            BentoCreate(oBentoExText, { text: "Label 3" });
            BentoCreate(oBentoExButton, { text: "Button 3" });
        }
    }
}