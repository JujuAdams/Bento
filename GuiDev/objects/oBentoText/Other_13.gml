/// @desc Reposition

// This event is called whenever the library decides that the element needs to be moved. This is
// typically when the element is created, the layout changes, or when the player has scrolled a
// element.
// 
// The textbox overrides the default reposition behavior in `oBentoAncestor`. Instead, we merely
// position the instance and let other systems do the hard work for us.

x = bentoX;
y = bentoY;