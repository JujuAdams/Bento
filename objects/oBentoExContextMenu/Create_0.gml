// Feather disable all

// This object defines a context menu. The context menu can be dismissed by clicking off of the
// menu or by activating the `BENTO_HOTKEY_CANCEL` hotkey.
// 
// Example:
// ```
// with(BentoCreate(oBentoExContextMenu))
// {
//     BentoCreate(oBentoExTest, { text: "Sort by" });
//     
//     BentoCreate(oBentoButton, {
//         text: "Value",
//         func: function() {
//             SortByValue();
//         }
//     });
//     
//     BentoCreate(oBentoButton, {
//         text: "Name",
//         func: function() {
//             SortByName();
//         }
//     });
//     
//     BentoCreate(oBentoButton, {
//         text: "Rarity",
//         func: function() {
//             SortByRarity();
//         }
//     });
// }
// ```

//Always call this in the Create event in objects that inherit from `oBentoAncestor`
event_inherited();

BentoLayoutList(BENTO_AXIS_Y, 0.5, 0);
BentoLayoutSetClampInside(true);
BentoLayoutSetResize(BENTO_RESIZE_DEFLATE, BENTO_RESIZE_DEFLATE);
BentoLayoutSetPadding(10, 10, 10, 10);
BentoLayoutSetGutter(10, 10);
BentoLayoutSetAnchor(0, 0);
BentoLayoutSetMinSize(32, 32);

BentoFocusOpen(BENTO_FOCUS_POINTER_DESTROY_ON_CLICK);

BentoSetDrawAfter(true);