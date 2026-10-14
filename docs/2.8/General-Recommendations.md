# General Recommendations

This page is devoted to general good practice to keep in mind as you're building a user interface with Bento. Nothing on this page is a hard-and-fast rule but you may find these insights helpful nonetheless.

&nbsp;

## Play sound effects carefully

It's easy for user interfaces to accidentally swamp a player with lots of irritating audio glitches. When playing sound effects when an element is hovered, you should probably always check against `BentoCursorGetEnterByNavigation()` instead of `BentoCursorGetEnter()`.

&nbsp;

## Only change visual state on hover

To ensure smooth operation between different [input modes](Topic-Input-Modes), it's best to keep hover behaviour simple and ideally restricted to a change in appearance or playing a sound effect. Opening submenus on hover, or really doing anything functional, might work well when using a mouse but will cause issues when the player is using the other input modes.