# Basic Positioning

&nbsp;

Bento comes with a powerful and fancy procedural layout system that helps you organise your user interface and react to different screen sizes. As lovely as it is, it's also complicated and needs a lot of explanation.

GameMaker developers are used to positioning user interface elements manually and Bento allows you to work this way as well. Positioning elements manually is a key feature. Keyboard and gamepad navigation will work regardless of how you lay out your elements.

Bento uses a [tree](Topic-Principles) to organise your user interface. Elements may be children of elements recursively. Of particular note for this article is that **children are positioned relative to their parent**. All child positions are internally defined are relative to their parent and if the parent moves then the child moves by the same amount.

As part of the aforementioned fancy layout system, each element can have a "layout type". Elements that have a layout type will set the position of their children. For manual positioning, we don't want this. To position elements manually, you must make sure to set the layout type of an element's parent to `BENTO_LAYOUT_RECT`. This will cause the parent to be a simple rectangle container.

There are a few functions available to set the position of an element. Please read on for further information.

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
|`[element]`|element |Element to target                                                               |

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

&nbsp;

## …LayoutSetSize

`BentoLayoutSetSize([width], [height], [element=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                      |
|-----------|--------|-----------------------------|
|`[width]`  |number  |Width to set for the element |
|`[height]` |number  |Height to set for the element|
|`[element]`|element |Element to target            |

Sets the baseline width and height for an element. You may use a value of `undefined` to indicate that a value in a particular axis should not be changed from its current value.

<!-- tabs:end -->

&nbsp;

## …LayoutSetAnchor

`BentoLayoutSetAnchor([x], [y], [element=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                                                                          |
|-----------|--------|-------------------------------------------------------------------------------------------------|
|`[x]`      |number  |x-axis anchor to align to within the parent. If not set, no change to the existing anchor is made|
|`[y]`      |number  |y-axis anchor to align to within the parent. If not set, no change to the existing anchor is made|
|`[element]`|element |Element to target                                                                                |

Sets the alignment for the element relative to the space available to it. When a parent has the `BENTO_LAYOUT_RECT` layout type then the space available to the target element is the size of the parent (minus padding).

`x` and `y` should be a value between `0` and `1`. If you choose a value of `0`, that will align an element to the left or the top of the available space. If you choose a value of `1`, that will align an element to the right or the bottom. A value of `0.5` therefore is the center or middle of the available space. You may pass `undefined` as either parameter to not change the existing value.

<!-- tabs:end -->

&nbsp;

## …LayoutSetPadding

`BentoLayoutSetPadding(size, [element=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                          |
|-----------|--------|---------------------------------|
|`size`     |number  |Padding to add inside the element|
|`[element]`|element |Element to target                |

Sets the symmetric padding inside an element. Positive padding values will position children away from the edges of the element towards the centre of the element.

<!-- tabs:end -->