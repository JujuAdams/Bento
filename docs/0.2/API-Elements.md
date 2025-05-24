# Elements

&nbsp;

## …SetParent

`BentoSetParent(parent, [target=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype|Purpose                                             |
|----------|--------|----------------------------------------------------|
|`parent`  |element |                                                    |
|`[target]`|element |                                                    |

Sets the parent for an instance.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …GetParent

`BentoGetParent([depth=1], [element=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name       |Datatype|Purpose                                             |
|-----------|--------|----------------------------------------------------|
|`[depth]`  |integer |                                                    |
|`[element]`|element |                                                    |

Returns a hierarchy ancestor of an instance. The default depth (`1`) will return an instance's immediate parent. Setting the depth parameter higher will return an ancestor further up the tree. If a `depth` parameter is higher than the number of ancestors, `GUI_ROOT` will be returned.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …IsAncestor

`BentoIsAncestor(element, [layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean

|Name      |Datatype|Purpose                                             |
|----------|--------|----------------------------------------------------|
|`ancestor`|element |                                                    |
|`child`   |element |                                                    |

Returns if the given child instance is a descendent of the given ancestor instance.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …DestroyChildren

`BentoDestroyChildren([parent=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype|Purpose                                             |
|----------|--------|----------------------------------------------------|
|`[parent]`|element |                                                    |

Destroys every child of a parent UI element.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->-->

&nbsp;

## …Select

`BentoSelect([parent=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype|Purpose                                             |
|----------|--------|----------------------------------------------------|
|`[parent]`|element |                                                    |

Selects an element (if possible). This function only works when the navigation mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …SelectOnDestroy

`BentoSelectOnDestroy(trigger, target)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name     |Datatype|Purpose                                             |
|---------|--------|----------------------------------------------------|
|`trigger`|element |                                                    |
|`target` |element |                                                    |

Sets up a condition that selects the `target` instance when the `trigger` instance is destroyed. You can set up this condition in any navigation mode but the `target` instance will only be selected when the navigation mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …SelectSoft

`BentoSelectSoft(element, [layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name     |Datatype|Purpose                                             |
|---------|--------|----------------------------------------------------|
|`element`|element |                                                    |
|`[layer]`|element |                                                    |

Preferentially selects an element if no other element is selected. A soft select will only last for a frame and can be overwritten by `BentoSelect()`. This function further only works when the navigation mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …ActivateInstances

`BentoActivateInstances()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Forces the activation of all GUI instances using GameMaker's native activation functions. This is helpful to call after instance deactivation calls to ensure instance elements remain functional.

#### **Example**

```gml
//Wake up every instance
instance_activate_all();

//Deactivate everything outside of the camera
var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);
var _vw = camera_get_view_width(view_camera[0]);
var _vh = camera_get_view_height(view_camera[0]);
instance_deactivate_region(_vx - 64, _vy - 64, _vw + 128, _vh + 128, false, false);

//Also make sure Bento instances are still active 
BentoActivateInstances();
```

<!-- tabs:end -->