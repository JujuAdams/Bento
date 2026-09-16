// Feather disable all

function TestReplaceableList()
{
    with(oMain)
    {
        BentoLayerClear("example layer");
        with(BentoCreateBlank(BentoGetRoot()))
        {
            BentoLayoutSetPadding(40);
            BentoLayoutSetGutter(35, 35);
            BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
            BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
            
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Scrolling List" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            with(BentoCreate(oBentoExScrollingList))
            {
                BentoLayoutSetPadding(10);
                BentoLayoutSetGutter(10, 10);
                BentoLayoutSetMaxSize(200, 295);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                
                var _index = 0;
                repeat(15)
                {
                    with(BentoCreate(oBentoExButton, {
                        text: string(_index),
                        func: function()
                        {
                            //with(BentoGetParent())
                            //{
                            //    BentoDestroyChildren();
                            //    BentoCreate(oBentoExText, { text: "Text!" });
                            //}
                            
                            with(BentoGetParent())
                            {
                                BentoSetChildArray([
                                    BentoCreate(oBentoExText, { text: "Text!" }),
                                ]);
                            }
                        },
                    }))
                    {
                        if (_index == 0) BentoHover();
                        BentoLayoutSetResize(BENTO_RESIZE_INFLATE, undefined);
                    }
                    
                    ++_index;
                }
            }
        }
    }
}