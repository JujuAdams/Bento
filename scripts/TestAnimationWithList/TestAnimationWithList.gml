// Feather disable all

function TestAnimationWithList()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Animation" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExButton, { text: "Replay", func: function()
            {
                BentoAnimPlayBuildIn(60, 0, 0, 0, 0, 0, undefined, undefined, undefined, BentoGetParent().list);
            }});
            
            list = BentoCreate(oBentoExScrollingListWithBar);
            with(list)
            {
                BentoLayoutSetMaxSize(undefined, 400);
                
                BentoLayoutSetPadding(40);
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
                
                var _i = 0;
                repeat(20)
                {
                    BentoCreate(oBentoExButton, { text: $"Button {_i}" });
                    ++_i;
                }
                
                BentoAnimPlayBuildIn(60, 0, 0, 0, 0, 0);
            }
            
            //with(BentoCreate(oBentoExButton, { text: "Replay", func: function()
            //{
            //    BentoForeachChild(function(_index, _metadata)
            //    {
            //        BentoAnimPlayBuildOut(45, 0, 1000, 0, 1, 1);
            //    },
            //    undefined,
            //    BentoGetParent());
            //}}))
            //{
            //    BentoSetCallbackOnDestroy(function()
            //    {
            //        ExampleHomePage();
            //    });
            //}
        }
    }
}