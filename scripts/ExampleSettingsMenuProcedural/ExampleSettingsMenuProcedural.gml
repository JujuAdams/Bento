// Feather disable all

function ExampleSettingsMenuProcedural()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Settings Menu" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, { text: "This is an example of a settings menu.", font: fntBentoExCandyBeans });
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Flimflams" });
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                }
                
                with(BentoCreate(oBentoExCheckbox, { reference: BentoRef(global.settingsStruct, "flimflams") }))
                {
                    BentoHoverSoft(self);
                }
            }
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Wibbles" });
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                }
                
                BentoCreate(oBentoExCheckbox, { reference: BentoRef(global.settingsStruct, "wibbles") });
            }
            
            with(BentoCreate(oBentoExFrame))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_Y, 0, 0);
                BentoLayoutSetPadding(20);
                BentoLayoutSetGutter(20, 20);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeans, text: "What type of jam do you bathe in?" });
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0, 0);
                    
                    BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Strawberry" });
                    
                    with(BentoCreate(oBentoExSpacer))
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                    
                    BentoCreate(oBentoExRadioButton, { value: "strawberry", reference: BentoRef(global.settingsStruct, "bathJam") });
                }
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0, 0);
                    
                    BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Raspberry" });
                    
                    with(BentoCreate(oBentoExSpacer))
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                    
                    BentoCreate(oBentoExRadioButton, { value: "raspberry", reference: BentoRef(global.settingsStruct, "bathJam") });
                }
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                    BentoLayoutList(BENTO_AXIS_X, 0, 0);
                    
                    BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Marmalade" });
                    
                    with(BentoCreate(oBentoExSpacer))
                    {
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    }
                    
                    BentoCreate(oBentoExRadioButton, { value: "marmalade", reference: BentoRef(global.settingsStruct, "bathJam") });
                }
            }
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0, 0.5);
                BentoLayoutSetGutter(20, 20);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Earth Flatness" });
                
                with(BentoCreate(oBentoExSlider, { reference: BentoRef(global.settingsStruct, "flatness") }))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_NORMAL);
                }
            }
            
            with(BentoCreate(oBentoExSpacer))
            {
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0, 0);
                
                BentoCreate(oBentoExStepperStrings, {
                    text: "Sailor Scout",
                    stringArray: ["Mercury", "Venus", "Earth", "Moon", "Mars", "Jupiter", "Saturn", "Uranus", "Pluto"],
                    reference: BentoRef(global.settingsStruct, "sailorScout"),
                });
                
                with(BentoCreate(oBentoExSpacer))
                {
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                }
                
                BentoCreate(oBentoExStepperNumbers, {
                    text: "Favourite Even Number",
                    valueMin: 2,
                    valueStep: 2,
                    reference: BentoRef(global.settingsStruct, "favoriteEvenNumber"),
                });
            }
            
            BentoCreate(oBentoExButton, { text: "Reset", font: fntBentoExCandyBeansBig, func: function()
            {
                BentoLayerCreate("reset settings modal");
                with(BentoCreate(oBentoExSpacer, undefined, BentoLayerGetRoot("reset settings modal")))
                {
                    BentoLayoutSetPadding(40);
                    BentoLayoutSetGutter(35, 35);
                    BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                    BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                    
                    with(BentoCreate(oBentoExModalFrame))
                    {
                        BentoLayoutSetPadding(40);
                        BentoLayoutSetGutter(35, 35);
                        BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                        BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
                        
                        BentoCreate(oBentoExText, {
                            text: "Are you sure you want to reset your settings? This cannot be undone!",
                            hAlign: fa_center,
                            font: fntBentoExCandyBeansBig,
                        });
                        
                        with(BentoCreate(oBentoExSpacer))
                        {
                            BentoLayoutSetPadding(40);
                            BentoLayoutSetGutter(35, 35);
                            BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                            BentoLayoutList(BENTO_AXIS_X, 0.5, 0.5);
                            
                            with(BentoCreate(oBentoExButton, { text: "No thanks", func: function()
                            {
                                BentoLayerDestroy();
                            }}))
                            {
                                BentoHoverSoft(self);
                            }
                            
                            BentoCreate(oBentoExButton, { text: "Yes, please reset", func: function()
                            {
                                global.settingsStruct.flimflams          = false;
                                global.settingsStruct.wibbles            = true;
                                global.settingsStruct.bathJam            = "strawberry";
                                global.settingsStruct.flatness           = 7;
                                global.settingsStruct.sailorScout        = "Moon";
                                global.settingsStruct.favoriteEvenNumber = 2;
                                BentoLayerDestroy();
                            }});
                        }
                    }
                }
            }});
        }
    }
}