# Basic Positioning

&nbsp;

Bento comes with a powerful and fancy procedural layout system that helps you organise your user interface and react to different screen sizes. As lovely as it is, it's also complicated and needs a lot of explanation.

GameMaker developers are used to positioning user interface elements manually and Bento allows you to work this way as well. Positioning elements manually is a key feature. Keyboard and gamepad navigation will work regardless of how you lay out your elements.

Bento uses a [tree](Topic-Principles) to organise your user interface. Elements may be children of elements recursively. Of particular note for this article is that **children are positioned relative to their parent**. All child positions are internally defined are relative to their parent and if the parent moves then the child moves by the same amount.

As part of the aforementioned fancy layout system, each element can have a "layout type". Elements that have a layout type will set the position of their children. For manual positioning, we don't want this. To position elements manually, you must make sure to set the layout type of an element's parent to `BENTO_LAYOUT_RECT`. This will cause the parent to be a simple rectangle container.

There are two functions available to set the position of an element, `BentoSetOffset()` and `BentoSetPosition()`.

&nbsp;

## …SetOffset

`BentoSetOffset([x], [y], [element=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                                                         |
|-----------|--------|--------------------------------------------------------------------------------|
|`[x]`      |number  |x-offset from the parent. If not set, no change to the existing offset is made  |
|`[y]`      |number  |y-offset from the parent. If not set, no change to the existing offset is made  |
|`[element]`|element |Element to target   
                                                            |
Sets the x and y offset for an element. You may use a value of `undefined` to indicate that a value in a particular axis should not be changed from its current value. Changing the offset value in either axis will at some point in the future trigger the "Reposition" user event / callback to be executed for the target element and any children of that element.

<!-- tabs:end -->

&nbsp;

## …SetPosition

`BentoSetPosition([x], [y], [element=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                                                                  |
|-----------|--------|-----------------------------------------------------------------------------------------|
|`[x]`      |number  |Absolute x position for the element. If not set, no change to the existing offset is made|
|`[y]`      |number  |Absolute y position for the element. If not set, no change to the existing offset is made|
|`[element]`|element |Element to target                                                                        |

Sets the absolute x and y position for an element. This is implemented as setting an offset from the parent's current position that results in the target element being at the specified position.

?> If the parent changes position after this function is called then the target element will also change position, likely moving away from the absolute position set by this function.

You may use a value of `undefined` to indicate that a value in a particular axis should not be changed from its current value. Calling this function with a new value in either axis will at some point in the future trigger the "Reposition" user event / callback to be executed for the target element and any children of that element.

<!-- tabs:end -->