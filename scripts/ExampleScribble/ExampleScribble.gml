// Feather disable all

function ExampleScribble()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Buttons" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePageJSON });
            }
            
            BentoCreate(oBentoExTextScribble, { font: fntBentoExCandyBeans, text: "[wave][sBentoExLogoSmall] Scribble Text! [sBentoExLogoSmall]" });
            BentoCreate(oBentoExTextScribbleJr, { font: fntBentoExCandyBeans, text: "[c_red]Scribble [c_lime]Junior [c_blue]Text!" });
        }
    }
}