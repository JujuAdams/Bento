# General Recommendations

This page is devoted to general good practice to keep in mind as you're building a user interface with Bento. Nothing on this page is a hard-and-fast rule but you may find these insights helpful nonetheless.

&nbsp;

## Only change visual state on hover

To ensure smooth operation between different [input modes](Topic-Input), it's best to keep hover behaviour simple and ideally restricted to a change in appearance or playing a sound effect. Opening submenus on hover, or really doing anything functional, might work well when using a mouse but will cause issues when the player is using the other input modes.