# Layouts

Bento uses a custom layout algorithm to determine where to place user interface elements. This layout system reduces the burden of calculating the precise position of elements yourself. Whilst this layout system is powerful, it does require some getting used to. If you'd prefer to use a simpler system, you're welcome to use [basic positioning code](Topic-Basic-Positioning); Bento's other features will work regardless.

Every Bento element has a "layout type". An element may only have one layout type at a time. Layouts control how children of a Bento element are arranged. Layout types are set by calling specific functions (e.g. `BentoLayoutList()`). Bento currently supports the following layout types:

- Rectangle (the default)
- Text
- List
- Grid

?> You can read more about text rendering in [this article](Topic-Text-Layouts).

Every element also has layout-specific properties that are stored internally. These properties are adjusted by calling functions such as `BentoLayoutSetSize()` or `BentoLayoutSetAnchor()`. Elements can be given special logic to execute during the layout calculation process, as set by `BentoLayoutSetResize()`.

Layout calculation is expensive and layouts are recalculated only when necessary. Element positions are cached wherever possible. If an element's position or size is changed then the ["Reposition" user event](Topic-User-Events) is executed.

&nbsp;

## The Algorithm

Bento's algorithm happens in multiple stages:

1. Traverse the tree of elements and build a flat array of elements to operate on. Whilst doing this, Bento also calculates a final padding value including scrollbars and scissor padding.

2. Iterate backwards and calculate the minimum viable **width** for elements.

3. Iterate forwards and resize the **width** of elements that need to be deflated or inflated.

4. Iterate backwards and calculate the minimum viable **height** for elements.

5. Iterate forwards and resize the **height** of elements that need to be deflated or inflated. If an element has the `BENTO_RESIZE_ASPECT` logic (see below) then its height is set here too.

6. Iterate forwards and finalise positions of all elements, including reversing positions for right-to-left interfaces.

Note that the calculation and resizing steps are separate for the x and y axes. This gives us the opportunity to resize user interface elements based on text wrapping.

You can change the logic that an element will when resizing by calling `BentoLayoutSetResize()`. You may set resize logic per axis e.g. you may want to resize on the x-axis but not resize on the y-axis. This function should be given the following `BENTO_RESIZE_*` constants:

### `BENTO_RESIZE_NORMAL`

The default layout logic for both the x and y axes. Using this logic, an element will shrink to fit the available space if necessary. Otherwise, an element will not change size.

### `BENTO_RESIZE_INFLATE`

Using this logic, an element will increase in size to fill empty space along an axis. An element will only fill space to fill its parent. An element using this logic will also scale down if necessary if there isn't enough space in the parent.

### `BENTO_RESIZE_DEFLATE`

Using this logic, an element will decrease in size to fit around its children. An element using this logic will also scale down if necessary if there isn't enough space in the parent. An element using this logic will also scale down if necessary if there isn't enough space in the parent.

### `BENTO_RESIZE_ASPECT`

This logic type can only be used for the y-axis. Using this logic, an element will set its height in proportion to its width keeping the same aspect ratio as the initial width and height.

&nbsp;

## Layout Types

### Rectangle

The default layout type.

&nbsp;

### Text

?> You can read more about text rendering in [this article](Topic-Text-Layouts).

&nbsp;

### Lists

&nbsp;

### Grids