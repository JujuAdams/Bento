// Feather disable all

//*
function ExampleButtonsWithLongClickProcedural()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = BentoCreate(oBentoExSpacer, undefined, BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPadding(40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Long-Click Buttons" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "Buttons typical activate once when clicked. However, for some use cases you may want to allow players to activate a behaviour (typically a secondary behaviour) when a button is pressed and held for longer than a normal click." });
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetGutter(20, 20);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                
                with(BentoCreate(oBentoExButtonWithLongClick, { text: "Button with long click" }))
                {
                    BentoSelect(self);
                }
                
                BentoCreate(oBentoExButton, { text: "Standard button" });
            }
        }
    }
}
//*

/*
function ExampleButtonsProcedural()
{
    with(oMain)
    {
        BentoDestroy(mainElement);
        
        mainElement = new BentoExConstrSpacer(BentoLayerGetRoot());
        with(mainElement)
        {
            BentoLayoutSetPaddingExt(40, 40, 40, 40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(new BentoExConstrSpacer())
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                new BentoExConstrText("Buttons", fntBentoExCandyBeans);
                new BentoExConstrButton(ExampleHomePage, "Back");
            }
            
            new BentoExConstrText("This example demonstrates various button behaviours. A \"button\" in Bento is any element that can be clicked by pressing the primary input (left mouse click, spacebar, [A] button on a gamepad etc.). Any element can be marked as a button.", fntBentoExCandyBeans);
            new BentoExConstrText("Buttons can further be filtered based on the input mode. There are occasions where a button should only be clickable in pointer (mouse and touch) modes or directional (keyboard and gamepad) modes. Use the equivalent constant when setting the button behaviour and Bento will take care of it for you.", fntBentoExCandyBeans);
            new BentoExConstrText("When a button is clicked, `BentoPrimaryGetClick()` will return `true` for one step, including in the Draw event for the element. You should only use this function for determining if a button has been deliberately clicked by the player; any other function is liable to return false values.", fntBentoExCandyBeans);
            
            with(new BentoExConstrSpacer())
            {
                BentoLayoutSetGutter(20, 20);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
                
                with(new BentoExConstrText("Always a button"))
                {
                    BentoSelect(self);
                    BentoSetButton(BENTO_BUTTON_ALWAYS);
                }
                
                with(new BentoExConstrText("Pointer-only button"))
                {
                    BentoSetButton(BENTO_BUTTON_POINTER);
                }
                
                with(new BentoExConstrText("Directional-only button"))
                {
                    BentoSetButton(BENTO_BUTTON_DIRECTIONAL);
                }
                
                with(new BentoExConstrText("Never a button"))
                {
                    BentoSetButton(BENTO_BUTTON_NEVER);
                }
            }
        }
    }
}
//*/