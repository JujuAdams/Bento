# The Layout Algorithm

Bento uses a custom layout algorithm to determine where to place user interface elements. This layout system reduces the burden of calculating the precise position of elements yourself. Whilst this layout system is powerful, it does require some getting used to. If you'd prefer to use a simpler system, you're welcome to use [basic positioning code](Topic-Basic-Positioning); Bento's other features will work regardless.

Every Bento element has a "layout type". An element may only have one layout type at a time. Bento currently supports the following layout types:

- Rectangle (the default)
- List
- Grid
- Text

?> You can read more about text rendering in [this article](Topic-Text-Layouts).

Layout types are set by calling specific functions (e.g. `BentoLayoutList()`). Every element also has layout-specific properties that are stored internally. These properties are adjusted by calling functions such as `BentoLayoutSetSize()` or `BentoLayoutSetAnchor()`.

Most importantly, UI elements can dynamically resize themselves as the algorithm proceeds based on how much space is available. Setting the resize logic is done with `BentoLayoutSetResize()`. There are four types of resize logic:

- `BENTO_RESIZE_NORMAL`
- `BENTO_RESIZE_INFLATE`
- `BENTO_RESIZE_DEFLATE`
- `BENTO_RESIZE_ASPECT` (y-axis only)

Layout calculation is expensive and layouts are recalculated only when necessary. Element positions are cached wherever possible. If an element's position or size is changed then the ["Reposition" user event](Topic-User-Events) is executed.

&nbsp;

## Layout Properties

### Size (& minimum & maximum)

### Resize

### Anchor

### Clamp Inside

### Padding & Gutter

### Setting from JSON

&nbsp;

## Rectangle

The default layout type.

## Lists

&nbsp;

## Grids

&nbsp;

## Text

?> You can read more about text rendering in [this article](Topic-Text-Layouts).