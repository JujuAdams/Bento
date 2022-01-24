# Layout Functions

&nbsp;

## `BentoLayout(padLeft, padTop, padRight, padBottom, overflowX, overflowY)`

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                                                                       |
|-----------|--------|----------------------------------------------------------------------------------------------|
|`padLeft`  |number  |Space to pad around the lefthand side of this box's children, in pixels                       |
|`padTop`   |number  |Space to pad around the topmost side of this box's children, in pixels                        |
|`padRight` |number  |Space to pad around the righthand side of this box's children, in pixels                      |
|`padBottom`|number  |Space to pad around the bottommost side of this box's children, in pixels                     |
|`overflowX`|enum    |Member of the `BENTO_OVERFLOW` enum (see below). Controls the overflow behaviour in the x-axis|
|`overflowY`|enum    |Member of the `BENTO_OVERFLOW` enum (see below). Controls the overflow behaviour in the y-axis|

The `BENTO_OVERFLOW` enum contains the following members:

|Member   |Purpose                                                                                                                                              |
|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
|`.IGNORE`|Places child boxes freely, even if they're outside the dimensions of the parent box                                                                  |
|`.SCROLL`|If any child box is outside the maximum dimensions of the parent box then a scroll bar is defined for the parent box                                 |
|`.WRAP`  |Only available when using `BentoLayoutGrid()`. Child boxes that exceed the maximum **pixel** dimensions of a grid box will be wrapped onto a new line|

&nbsp;

## `BentoLayoutGrid(maxCellsX, maxCellsY, gutterX, gutterY, flowStart, rowMajor)`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                         |
|---------------|--------|----------------------------------------------------------------------------------------------------------------|
|`maxCellsX`    |integer |Maximum width of the layout grid, in cells. Use `infinity` for no limit                                         |
|`maxCellsY`    |integer |Maximum height of the layout grid, in cells. Use `infinity` for no limit                                        |
|`gutterX`      |number  |Space between columns of children, in pixels                                                                    |
|`gutterY`      |number  |Space between rows of children, in pixels                                                                       |
|`flowStart`    |enum    |Member of the `BENTO_FLOW_START` enum. See below                                                                |
|`rowMajor`     |boolean |Whether to place children in the grid by filling rows before columns. Set to `false` to fill columns before rows|

The `BENTO_FLOW_START` enum contains the following members:

|Member         |Purpose                                                      |
|---------------|-------------------------------------------------------------|
|`.TOP_LEFT`    |Fill from the top-left corner towards the bottom-right corner|
|`.TOP_RIGHT`   |Fill from the top-right corner towards the bottom-left corner|
|`.BOTTOM_LEFT` |Fill from the bottom-left corner towards the top-right corner|
|`.BOTTOM_RIGHT`|Fill from the bottom-right corner towards the top-left corner|

&nbsp;

## `BentoLayoutGridLinebreak()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Forces children to start their layout on the next line. Whether this is a row or column is determined by the `rowMajor` argument for `BentoLayoutGrid()`.
