# Basic Functions

&nbsp;

## `BentoOpen([name])`

**Returns:** String, the UUID for the Bento box

|Name    |Datatype|Purpose                                                                                                        |
|--------|--------|---------------------------------------------------------------------------------------------------------------|
|`[name]`|string  |Optional. If not specified, the name is set to the same as the UUID for the Bento box (i.e. randomly generated)|

&nbsp;

## `BentoClose()`

**Returns:** String, the UUID for the Bento box

|Name   |Datatype|Purpose      |
|-------|--------|-------------|
|`value`|any     |Value to test|

&nbsp;

## `BentoData(value)`

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                                      |
|-------|--------|---------------------------------------------|
|`value`|any     |Value to set for the currently open Bento box|

This function sets a special variable on the currently open Bento box for your own use. This can be useful to tie a Bento box to another specific data structure, such as a struct, or can be used to hold a reference to some other piece of data, such as a ds_map key.

&nbsp;

## `BentoResult(rootUUID)`

**Returns:** Array, all the boxes defined inside the given root box

|Name      |Datatype|Purpose                                                 |
|----------|--------|--------------------------------------------------------|
|`rootUUID`|string  |The UUID for the root box, as returned by `BentoClose()`|

Returns an array of Bento box structs, with their positions and dimensions solved as determined by the layout rules and constraints you have set. The array is flat and not a tree-based. Array elements are structs that contain the following information:

|Member variable|Datatype|Purpose                                                                                                            |
|---------------|--------|-------------------------------------------------------------------------------------------------------------------|
|`.name`        |string  |Name of the box, as set by `BentoOpen()`                                                                           |
|`.uuid`        |string  |UUID for the box, randomly generated and unique                                                                    |
|`.left`        |number  |Lefthand coordinate for the box, in pixels                                                                         |
|`.top`         |number  |Top-most coordinate for the box, in pixels                                                                         |
|`.right`       |number  |Righthand coordinate for the box, in pixels                                                                        |
|`.bottom`      |number  |Bottom-most coordinate for the box, in pixels                                                                      |
|`.data`        |any     |The data value set by `BentoData()`, or `undefined` if no data value was set                                       |
|`.parent`      |string  |UUID for this box's parent. The root element will have a value of `undefined`                                      |
|`.children`    |array   |Array of UUIDs that enumerate this box's children. If the box has no children this will have a value of `undefined`|