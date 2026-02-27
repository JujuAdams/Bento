function ExampleMainMenu()
{
    mainElement = BentoCreate(oBentoExList, undefined, BentoGetRoot());
    with(mainElement)
    {
        BentoSetVisible(false);
        BentoLayoutSetAnchor(0.5, 0.5);
        BentoLayoutSetGutter(0, 10);
        
        BentoCreate(oBentoExText, {
            text: "Main Menu"
        });
        
        BentoCreate(oBentoExButton, {
            text: "New Game",
            func: function()
            {
                show_debug_message("New Game");
            }
        });
        
        BentoCreate(oBentoExButton, {
            text: "Load Game",
            func: function()
            {
                show_debug_message("Load Game");
            }
        });
        
        BentoCreate(oBentoExButton, {
            text: "Quit Game",
            func: function()
            {
                game_end();
            }
        });
    }
}