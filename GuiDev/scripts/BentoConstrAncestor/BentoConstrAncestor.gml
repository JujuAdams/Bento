// Feather disable all

/// @param parent

function BentoConstrAncestor(_parent) constructor
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
    
    bentoLeft   = 0;
    bentoTop    = 0;
    bentoRight  = 0;
    bentoBottom = 0;
    bentoX      = 0;
    bentoY      = 0;
    bentoWidth  = 0;
    bentoHeight = 0;
    
    BENTO_VARS = new __BentoClassVariables(self);
    BentoSetParent(_parent);
}