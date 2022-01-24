# Layout Functions

&nbsp;

## `LayoutGrid(maxCellsX, maxCellsY, flowDirection, flowStart, overflowRule)`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                 |
|---------------|--------|------------------------------------------------------------------------|
|`maxCellsX`    |integer |Maximum width of the layout grid, in cells. Use `infinity` for no limit |
|`maxCellsY`    |integer |Maximum height of the layout grid, in cells. Use `infinity` for no limit|
|`flowDirection`|enum    |Member of the `BENTO_FLOW_DIRECTION` enum. See below                    |
|`flowStart`    |enum    |Member of the `BENTO_FLOW_START` enum. See below                        |
|`overflowRules`|enum    |Member of the `BENTO_OVERFLOW` enum. See below                          |

|Member         |Purpose|
|---------------|-------|
|`.ROW_MAJOR`   |       |
|`.COLUMN_MAJOR`|       |

|Member         |Purpose|
|---------------|-------|
|`.TOP_LEFT`    |       |
|`.TOP_RIGHT`   |       |
|`.BOTTOM_LEFT` |       |
|`.BOTTOM_RIGHT`|       |

|Member   |Purpose|
|---------|-------|
|`.CLIP`  |       |
|`.WRAP`  |       |
|`.SCROLL`|       |

&nbsp;

## `LayoutPadding(left, top, right, bottom, gutterX, gutterY)`

**Returns:** N/A (`undefined`)

|Name     |Datatype|Purpose                                                                  |
|---------|--------|-------------------------------------------------------------------------|
|`left`   |number  |Space to pad around the lefthand side of this box's children, in pixels  |
|`top`    |number  |Space to pad around the topmost side of this box's children, in pixels   |
|`right`  |number  |Space to pad around the righthand side of this box's children, in pixels |
|`bottom` |number  |Space to pad around the bottommost side of this box's children, in pixels|
|`gutterX`|number  |Space between columns of children, in pixels                             |
|`gutterY`|number  |Space between rows of children, in pixels                                |

&nbsp;

## `LayoutLinebreak()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Forces children to start their layout on the next line. Whether this is a row or column is determined by the flow direction for the layout.
