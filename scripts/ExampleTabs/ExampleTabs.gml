// Feather disable all

function ExampleTabs()
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
                
                BentoCreate(oBentoExText, { font: fntBentoExCandyBeansBig, text: "Tabs" });
                BentoCreate(oBentoExBackButton, { func: ExampleHomePage });
            }
            
            BentoCreate(oBentoExText, { text: "Tabs are useful to quickly swap between different UI pages and commonly appear on pause menus. When a tab button is clicked, the contents of the frame are cleared and new child elements are created." });
            BentoCreate(oBentoExText, { text: "Tab buttons usually work differently between pointer and navigation input. When using a keyboard or gamepad, the tab buttons are not clickable. Instead, the Q/E keys or a gamepad's shoulder button swaps between tabs. When using a mouse or touchscreen, tab buttons are clickable." });
            
            //Horizontal tab bar
            with(BentoCreateBlank())
            {
                BentoLayoutSetGutter(35, 35);
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_DEFLATE);
                BentoLayoutList(BENTO_AXIS_X, 0.5, 0);
                
                //Each tab button has a unique `ident` variable. When we open a tab (see below), this
                //variable is checked against the tab contents. This tells us which tab is open
                BentoCreate(oBentoExTabButton, { text: "Red",    targetName: "tab container", ident: "red",    func: ExampleTabsRed    });
                BentoCreate(oBentoExTabButton, { text: "Green",  targetName: "tab container", ident: "green",  func: ExampleTabsGreen  });
                BentoCreate(oBentoExTabButton, { text: "Blue",   targetName: "tab container", ident: "blue",   func: ExampleTabsBlue   });
                BentoCreate(oBentoExTabButton, { text: "Yellow", targetName: "tab container", ident: "yellow", func: ExampleTabsYellow });
            }
            
            //Container for tab contents
            with(BentoCreate(oBentoExFrame, { fill: false }))
            {
                BentoNameSet("tab container");
                BentoLayoutSetResize(BENTO_RESIZE_INFLATE, BENTO_RESIZE_INFLATE);
                
                BentoLayoutSetPadding(20);
                BentoLayoutSetGutter(20, 20);
                BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);
            }
            
            //Open the "red" page by default
            ExampleTabsRed();
        }
    }
}

function ExampleTabsRed()
{
    with(BentoNameFind("tab container"))
    {
        //Set this tab's `ident` variable. This should match the `ident` variable for the tab button
        //that executes this function
        ident = "red";
        
        //Clear out all of the old child elements. We can also reformat the container here if we want
        BentoDestroyChildren();
        
        BentoCreate(oBentoExButton, { text: "Autumn Leaves" });
        BentoHover(BENTO_PREV_ELEMENT); //Always highlight the top option when this tab is opened
        BentoCreate(oBentoExButton, { text: "Beetroot" });
        BentoCreate(oBentoExButton, { text: "Chilli" });
        BentoCreate(oBentoExButton, { text: "Dragonfruit" });
    }
}

function ExampleTabsGreen()
{
    with(BentoNameFind("tab container"))
    {
        //Set this tab's `ident` variable. This should match the `ident` variable for the tab button
        //that executes this function
        ident = "green";
        
        //Clear out all of the old child elements. We can also reformat the container here if we want
        BentoDestroyChildren();
        
        BentoCreate(oBentoExButton, { text: "Avocado Toast" });
        BentoHover(BENTO_PREV_ELEMENT); //Always highlight the top option when this tab is opened
        BentoCreate(oBentoExButton, { text: "Basil" });
        BentoCreate(oBentoExButton, { text: "Crocodile" });
        BentoCreate(oBentoExButton, { text: "Dragonfly" });
    }
}

function ExampleTabsBlue()
{
    with(BentoNameFind("tab container"))
    {
        //Set this tab's `ident` variable. This should match the `ident` variable for the tab button
        //that executes this function
        ident = "blue";
        
        //Clear out all of the old child elements. We can also reformat the container here if we want
        BentoDestroyChildren();
        
        BentoCreate(oBentoExButton, { text: "Airplane" });
        BentoHover(BENTO_PREV_ELEMENT); //Always highlight the top option when this tab is opened
        BentoCreate(oBentoExButton, { text: "Bluebird" });
        BentoCreate(oBentoExButton, { text: "Cobalt" });
        BentoCreate(oBentoExButton, { text: "Dragon (blue)" });
    }
}

function ExampleTabsYellow()
{
    with(BentoNameFind("tab container"))
    {
        //Set this tab's `ident` variable. This should match the `ident` variable for the tab button
        //that executes this function
        ident = "yellow";
        
        //Clear out all of the old child elements. We can also reformat the container here if we want
        BentoDestroyChildren();
        
        BentoCreate(oBentoExButton, { text: "Amber" });
        BentoHover(BENTO_PREV_ELEMENT); //Always highlight the top option when this tab is opened
        BentoCreate(oBentoExButton, { text: "Banana" });
        BentoCreate(oBentoExButton, { text: "Canary" });
        BentoCreate(oBentoExButton, { text: "Duckling" });
    }
}