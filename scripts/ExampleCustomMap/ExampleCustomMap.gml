// Feather disable all

function ExampleCustomMap()
{
    with(oMain)
    {
        BentoLayerClear("example layer");
        with(BentoCreateBlank(BentoGetRoot()))
        {
            BentoLayoutSetPaddingExt(40, 40, 40, 40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Custom Map" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "This page demonstrates how to make a custom element, such as a navigable map. When using mouse or touch input, the map can be clicked and dragged. When using a keyboard or gamepad then the map must first be focused and then the arrow keys/thumbstick can be used to move the map." });
            
            with(BentoCreate(oBentoExMap))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            }
        }
    }
}