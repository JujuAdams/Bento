# Layers

&nbsp;

Bento UI elements are arranged on layers. Each layer has precisely one root UI element which acts as the tying-off point for whatever UI layout you need to exist on that layer. Layers must have unique names. Layers additionally have a `priority` variable that controls the order that Bento layers are processed (for both user inout and drawing purposes). Layers have methods that allow them to be placed over other layers, to be pushed to the very top of the stack, or to be drawn at a specific priority.

T#he behaviour of UI elements stored on layers can be controlled by setting the `behavior` variable on a layer. This behaviour variable can be used to change how UI elements on that layer function, but it is also used to control how subsequent (deeper / later) layers behave too. For example, a layer whose behaviour is set to `BENTO_BEHAVIOR_BLOCKING` will prevent all subsequent layers from receiving input or even drawing.

&nbsp;

## Variables

?> Whilst layers have variables that might make them look like UI elements they are, in fact, not UI elements in the conventional sense.

Available variables (in addition to shared UI variables) are:

| Name       | Datatype | Purpose                                                                                      |
|------------|----------|----------------------------------------------------------------------------------------------|
| `name`     | string   | Name of the layer                                                                            |
| `volatile` | boolean  | Whether the layer will be deleted if `LayerSustain()` is not called                          |
| `priority` | number   | Draw/input-handling priority for the layer. High priorities are handled first                |
| `behavior` | number   | Whether this layer allows subsequent layers to draw/handle input. See below for legal values |
| `left`     | number   | Worldspace left x-coordinate of the layer                                                    |
| `top`      | number   | Worldspace top y-coordinate of the layer                                                     |
| `right`    | number   | Worldspace right x-coordinate of the layer                                                   |
| `bottom`   | number   | Worldspace bottom y-coordinate of the layer                                                  |
| `x`        | number   | Worldspace x-coordinate in the centre of the layer                                           |
| `y`        | number   | Worldspace y-coordinate in the centre of the layer                                           |
| `width`    | number   | Worldspace width of the layer                                                                |
| `height`   | number   | Worldspace height of the layer                                                               |

The `.behavior` variable can take one of the following values:

| Name                         | Behaviour                                                                                                         |
|------------------------------|-------------------------------------------------------------------------------------------------------------------|
| `BENTO_BEHAVIOR_DRAW_ONLY`   | Doesn't receive input. Will draw and will allow input to pass through                                             |
| `BENTO_BEHAVIOR_PASSTHROUGH` | Receives input. Will draw and will allow input to pass through                                                    |
| `BENTO_BEHAVIOR_MODAL`       | Receives input and blocks subsequent layers from receiving input. Draws                                           |
| `BENTO_BEHAVIOR_BLOCKING`    | Receives input and blocks subsequent layers from receiving input. Draws and blocks subsequent layers from drawing |

&nbsp;

## Methods

Layers also have the following methods:

&nbsp;

### .MoveToTop()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Moves the layer to the top of the host's stack, causing it to be processed and drawn first.

&nbsp;

### .MoveOver(targetLayerName)

Returns: <undefined>

| Argument Name     | Datatype | Purpose                        |
|-------------------|----------|--------------------------------|
| `targetLayerName` | string   | Name of the layer to move over |

Moves the layer over the target layer. This sets the priority of the scoped layer to be the same as
the target layer.

&nbsp;

### .AnimateEnter()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Triggers (or re-triggers) the entry animation for every child of the layer.

&nbsp;

### .AnimateExit()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Triggers the exit animation for every child of the layer. When the animations are all finished, the layer is destroyed.

&nbsp;

### .HasChildren()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Returns whether the layer has any children.

&nbsp;

## Variable Access

### .VariableBind(variableName, getterFunc, setterFunc)

Returns: <undefined>

| Argument Name  | Datatype | Purpose                                                       |
|----------------|----------|---------------------------------------------------------------|
| `variableName` | string   | Name of the variable to bind to                               |
| `getterFunc`   | function | Function to call when getting the value of the named variable |
| `setterFunc`   | function | Function to call when setting the value of the named variable |

The bindings set by this method are used by Catspeak when executing BentoScript, and they are also used by the `.Get()` and `.Set()` methods. Trying to use standard GML syntax to get/set variables that have been bound using `.VariableBind()` will fail.

&nbsp;

### .Get(variableName)

Returns: <undefined>

| Argument Name  | Datatype | Purpose                     |
|----------------|----------|-----------------------------|
| `variableName` | string   | Name of the variable to get |

Executes the getter function if it exists, as set by `.VariableBind()`, otherwise the variable is read directly.

&nbsp;

### .Set(variableName, value)

Returns: <undefined>

| Argument Name  | Datatype | Purpose                     |
|----------------|----------|-----------------------------|
| `variableName` | string   | Name of the variable to set |
| `value`        | any      | Value to set                |

Executes the setter function if it exists, as set by `.VariableBind()`, otherwise the variable is set directly.