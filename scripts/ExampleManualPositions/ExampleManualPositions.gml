// Feather disable all

function ExampleManualPositions()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreate(oBentoExSpacer, undefined, BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPaddingExt(40, 40, 40, 40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Manual Positions" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "Bento has fancy tools to automatically lay out elements but often manual positioning is more convenient." });
            
            with(BentoCreate(oBentoExFrame))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                BentoLayoutSetPadding(20);
                
                BentoCreate(oBentoExButton, { text: "Hello" });
                
                with(BentoCreate(oBentoExButton, { text: "World" }))
                {
                    BentoSetOffset(100, 0);
                }
                
                with(BentoCreate(oBentoExButton, { text: "Bottom-right" }))
                {
                    BentoLayoutSetAnchor(1, 1);
                }
                
                with(BentoCreate(oBentoExButton, { text: "Centre-middle" }))
                {
                    BentoLayoutSetAnchor(0.5, 0.5);
                }
                
                with(BentoCreate(oBentoExButton, { text: "400, 330" }))
                {
                    BentoSetPosition(400, 330);
                }
                
                with(BentoCreate(oBentoExTextDynamic, { text: function()
                {
                    return $"{BentoCursorGetX()}, {BentoCursorGetY()}";
                }}))
                {
                    BentoLayoutSetAnchor(1, 0);
                }
            }
        }
    }
}