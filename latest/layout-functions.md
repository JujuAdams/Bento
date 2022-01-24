# Layout Functions

&nbsp;

## `LayoutCanvas(left, top, right, bottom, overflowX, overflowY)`

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                                                                       |
|-----------|--------|----------------------------------------------------------------------------------------------|
|`left`     |number  |Space to pad around the lefthand side of this box's children, in pixels                       |
|`top`      |number  |Space to pad around the topmost side of this box's children, in pixels                        |
|`right`    |number  |Space to pad around the righthand side of this box's children, in pixels                      |
|`bottom`   |number  |Space to pad around the bottommost side of this box's children, in pixels                     |
|`overflowX`|enum    |Member of the `BENTO_OVERFLOW` enum (see below). Controls the overflow behaviour in the x-axis|
|`overflowY`|enum    |Member of the `BENTO_OVERFLOW` enum (see below). Controls the overflow behaviour in the y-axis|

The `BENTO_OVERFLOW` enum contains the following members:

|Member   |Purpose|
|---------|-------|
|`.CLIP`  |       |
|`.WRAP`  |       |
|`.SCROLL`|       |

&nbsp;

## `LayoutGrid(maxCellsX, maxCellsY, gutterX, gutterY, flowStart, rowMajor)`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                 |
|---------------|--------|------------------------------------------------------------------------|
|`maxCellsX`    |integer |Maximum width of the layout grid, in cells. Use `infinity` for no limit |
|`maxCellsY`    |integer |Maximum height of the layout grid, in cells. Use `infinity` for no limit|
|`gutterX`      |number  |Space between columns of children, in pixels                            |
|`gutterY`      |number  |Space between rows of children, in pixels                               |
|`flowStart`    |enum    |Member of the `BENTO_FLOW_START` enum. See below                        |
|`rowMajor`     |boolean |Whether to place children in the grid by filling rows before columns. Set to `false` to fill columns before rows|

The `BENTO_FLOW_START` enum contains the following members:

|Member         |Purpose                                                      |
|---------------|-------------------------------------------------------------|
|`.TOP_LEFT`    |Fill from the top-left corner towards the bottom-right corner|
|`.TOP_RIGHT`   |Fill from the top-right corner towards the bottom-left corner|
|`.BOTTOM_LEFT` |Fill from the bottom-left corner towards the top-right corner|
|`.BOTTOM_RIGHT`|Fill from the bottom-right corner towards the top-left corner|

&nbsp;

## `LayoutGridLinebreak()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Forces children to start their layout on the next line. Whether this is a row or column is determined by the `rowMajor` argument for `BentoLayoutGrid()`.
