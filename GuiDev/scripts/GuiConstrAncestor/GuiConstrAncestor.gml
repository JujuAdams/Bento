// Feather disable all

/// 
/// 
/// @param parent

function GuiConstrAncestor(_parent) constructor
{
    funcStep = function()
    {
        
    }
    
    funcDraw = function()
    {
        
    }
    
    funcDrawAfter = function()
    {
        
    }
    
    funcReposition = function()
    {
        
    }
    
    ///////////////////////////
    //                       //
    //  Read-Only Variables  //
    //                       //
    ///////////////////////////
    
    //These variables give the position of various parts of this instance in worldspace. They're
    //read-only in the sense that they are liable to get overwritten by the library at unexpected
    //times.
    
    guiLeft   = 0;
    guiTop    = 0;
    guiRight  = 0;
    guiBottom = 0;
    guiX      = 0;
    guiY      = 0;
    guiWidth  = 0;
    guiHeight = 0;
    
    GUI_VARS = new __GuiClassVariables(self);
    GuiSetParent(_parent);
}