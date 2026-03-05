// Feather disable all

// This object defines a simple text button that can be used within a Bento UI layout. The button
// will execute a callback function when clicked.
// 
// You may specify the following variables when creating an instance of this object with
// `BentoCreate()`.
// 
// .func
//     The function to execute when the button is clicked. This function will always be re-scaoped such
//     that the function is executed in the scope of the button instance.
// 
// Example:
// ```
// BentoCreate(oBentoButton, {
//     text: "Quit to Desktop",
//     func: function() {
//         game_end();
//     }
// });
// ```

text = "Back";

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();