// Feather disable all

function ExampleMainMenu()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreate(oBentoExSpacer, undefined, BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPadding(20);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetAnchor(0.5, 0.5);
                
                BentoLayoutSetGutter(0, 60);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetGutter(20, 20);
                    BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                    
                    BentoCreate(oBentoExSpriteWithShadow, { sprite_index: sBentoExLogoBig });
                
                    BentoCreate(oBentoExText, { text: "Game Title", font: fntBentoExCandyBeansBig });
                }
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetGutter(20, 20);
                    BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                    
                    
                    with(BentoCreate(oBentoExButton, { text: "New Game" }))
                    {
                        BentoHover();
                        BentoSetNavigationWrap(false, true);
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                    
                    with(BentoCreate(oBentoExButton, { text: "Load Game" }))
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                    
                    with(BentoCreate(oBentoExButton, { text: "Options" }))
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                    
                    with(BentoCreate(oBentoExButton, { text: "Quit", func: ExampleHomePageJSON }))
                    {
                        BentoSetNavigationWrap(false, true);
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                }
            }
                
            with(BentoCreate(oBentoExText, { text: "Juju Adams", font: fntBentoExCandyBeans }))
            {
                BentoLayoutSetAnchor(0, 1);
            }
                
            with(BentoCreate(oBentoExText, { text: BENTO_VERSION, font: fntBentoExCandyBeans }))
            {
                BentoLayoutSetAnchor(1, 1);
            }
        }
    }
}