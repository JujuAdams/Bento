# Shared Methods

&nbsp;

The methods on this page are available across all UI elements.

&nbsp;

## Overview

?> There's more detail below - scroll down!

| Method                   | Usage                                                                                                     |
|--------------------------|-----------------------------------------------------------------------------------------------------------|
| `toString`               | Called by `string()`. Returns the UI element's identifier                                                 |
| `Destroy`                | Immediately destroys the UI element, freeing any memory associated with it                                |
| `GetType`                | Returns the type of the UI element                                                                        |
| `LayoutAsVerticalList`   | Sets up a vertical list layout                                                                            |
| `LayoutAsHorizontalList` | Sets up a horizontal list layout                                                                          |
| `LayoutAsGrid`           | Sets up a grid layout with cells of identical size                                                        |
| `LayoutAsColumns`        | Sets up a column layout. Children on the same row are vertically aligned                                  |
| `LayoutGetArray`         | Returns an ordered array of child elements to lay out                                                     |
| `AnimationEnter`         | Starts an entry animation for this UI element and its children                                            |
| `AnimationExit`          | Starts an exit animation for this UI element and its children. When complete, the UI element is destroyed |
| `AnimationFinish`        | Immediately skips any in-progress animation                                                               |
| `GetAnimation`           | Returns the current animation state                                                                       |
| `AnimateX`               | Sets up an animation in the x-axis                                                                        |
| `AnimateY`               | Sets up an animation in the y-axis                                                                        |
| `AnimateXY`              | Sets up an animation in both the x-axis and y-axis                                                        |
| `AnimateScale`           | Sets up an animation using the UI element's scale                                                         |
| `AnimateAlpha`           | Sets up an animation using the UI element's alpha transparency                                            |
| `AnimateColor`           | Sets up an animation using the UI element's colour blending                                               |
| `HasChildren`            | Returns if the UI element has children                                                                    |
| `ChildrenClear`          | Removes all children from the UI element                                                                  |
| `ParentChange`           | Moves from one parent to another                                                                          |
| `GetHover`               | Returns whether the UI element is being highlighted                                                       |
| `GetFocus`               | Returns whether the UI element is being focused                                                           |
| `GetButton`              | Returns whether the UI element is being clicked                                                           |
| `HoverStateSet`          | Sets the highlight state                                                                                  |
| `ButtonStateSet`         | Sets the button state                                                                                     |
| `Find`                   | Tries to find a UI element descendent with an identifier                                                  |
| `FindType`               | Finds all descendents with a given type                                                                   |
| `ReplaceFromFile`        | Replaces the UI element with the result of executing a BentoScript                                        |
| `VariableBind`           | Binds a getter and setter function to a variable name                                                     |
| `Get`                    | Calls the getter function (see above)                                                                     |
| `Set`                    | Calls the setter function (see above)                                                                     |

&nbsp;

## Basics

### .toString()

Returns: Identifier for the UI element, as a string

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

The function is also used internally by GameMaker when using the native string() function. This means that stringifying a UI struct will return its identifier.

&nbsp;

### .Destroy()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Destroys the UI element, freeing any memory associated with it. This is not necessary to call to clean up UI elements as garbage collection takes care of that for us, but this function is helpful for targeted removal of UI elements.

&nbsp;

### .GetType()

Returns: Type of the UI element, as a string

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

The "type" of a UI element is typically the instanceof() of the constructor that created the element e.g. a BentoButton builder in a BentoScript will generate a UI element with the type "BentoClassButton".

&nbsp;

## Layout

### .LayoutAsVerticalList(hAlign, spacing)

Returns:

| Argument Name | Datatype | Purpose                                     |
|---------------|----------|---------------------------------------------|
| `hAlign`      | string   |                                             |
| `spacing`     | number   |                                             

&nbsp;

### .LayoutAsHorizontalList(vAlign, spacing)

Returns:

| Argument Name | Datatype | Purpose                                     |
|---------------|----------|---------------------------------------------|
| `vAlign`      | string   |                                             |
| `spacing`     | number   |                                             |

&nbsp;

### .LayoutAsGrid(cellWidth, cellHeight)

Returns:

| Argument Name | Datatype | Purpose                                     |
|---------------|----------|---------------------------------------------|
| `cellWidth`   | number   |                                             |
| `cellHeight`  | number   |                                             |

&nbsp;

### .LayoutAsColumns(hAlign, spacing, widthArray)

Returns:

| Argument Name | Datatype | Purpose                                     |
|---------------|----------|---------------------------------------------|
| `vAlign`      | string   |                                             |
| `spacing`     | number   |                                             |
| `widthArray`  | array    |                                             |

&nbsp;

### .LayoutGetArray()

Returns: Ordered array of child elements to lay out

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

&nbsp;

## Animation

### .AnimationEnter()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Restarts the entry animation.

&nbsp;

### .AnimationExit()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Starts the exit animation. When finished, the UI element is destroyed.

&nbsp;

### .AnimationFinish()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Immediately skips any in-progress animation.

&nbsp;

### .GetAnimation()

Returns: The animation state.

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

&nbsp;

### .AnimateX(start, duration, delay = 0, animCurve = undefined)

Returns:

| Argument Name | Datatype        | Purpose                          |
|---------------|-----------------|----------------------------------|
| `start`       | number          | Starting value for the animation |
| `duration`    | number          | Duration of the tween            |
| `delay`       | number          | Initial delay for the tween      |
| `animCurve`   | animation curve | Animation curve to use           |

!> If you're calling this method from BentoScript, don't forget to call `BentoAddAsset()` to expose animation curves for use in BentoScript.

&nbsp;

### .AnimateY(start, duration, delay = 0, animCurve = undefined)

Returns:

| Argument Name | Datatype        | Purpose                          |
|---------------|-----------------|----------------------------------|
| `start`       | number          | Starting value for the animation |
| `duration`    | number          | Duration of the tween            |
| `delay`       | number          | Initial delay for the tween      |
| `animCurve`   | animation curve | Animation curve to use           |

!> If you're calling this method from BentoScript, don't forget to call `BentoAddAsset()` to expose animation curves for use in BentoScript.

&nbsp;

### .AnimateXY(startX, startY, duration, delay = 0, animCurve = undefined)

Returns:

| Argument Name | Datatype        | Purpose                                                  |
|---------------|-----------------|----------------------------------------------------------|
| `startX`      | number          | Starting value for the x-axis component of the animation |
| `startY`      | number          | Starting value for the y-axis component of the animation |
| `duration`    | number          | Duration of the tween                                    |
| `delay`       | number          | Initial delay for the tween                              |
| `animCurve`   | animation curve | Animation curve to use                                   |

!> If you're calling this method from BentoScript, don't forget to call `BentoAddAsset()` to expose animation curves for use in BentoScript.

&nbsp;

### .AnimateScale(start, duration, delay = 0, animCurve = undefined)

Returns:

| Argument Name | Datatype        | Purpose                          |
|---------------|-----------------|----------------------------------|
| `start`       | number          | Starting value for the animation |
| `duration`    | number          | Duration of the tween            |
| `delay`       | number          | Initial delay for the tween      |
| `animCurve`   | animation curve | Animation curve to use           |

!> If you're calling this method from BentoScript, don't forget to call `BentoAddAsset()` to expose animation curves for use in BentoScript.

&nbsp;

### .AnimateAlpha(start, duration, delay = 0, animCurve = undefined)

Returns:

| Argument Name | Datatype        | Purpose                          |
|---------------|-----------------|----------------------------------|
| `start`       | number          | Starting value for the animation |
| `duration`    | number          | Duration of the tween            |
| `delay`       | number          | Initial delay for the tween      |
| `animCurve`   | animation curve | Animation curve to use           |

!> If you're calling this method from BentoScript, don't forget to call `BentoAddAsset()` to expose animation curves for use in BentoScript.

&nbsp;

### .AnimateColor(blendColor, startFactor, duration, delay = 0, animCurve = undefined)

Returns:

| Argument Name | Datatype        | Purpose                                 |
|---------------|-----------------|-----------------------------------------|
| `blendColor`  | RGB             | Starting blend colour                   |
| `startFactor` | number          | Starting blend amount for the animation |
| `duration`    | number          | Duration of the tween                   |
| `delay`       | number          | Initial delay for the tween             |
| `animCurve`   | animation curve | Animation curve to use                  |

!> If you're calling this method from BentoScript, don't forget to call `BentoAddAsset()` to expose animation curves for use in BentoScript.

&nbsp;

## Children & Parents

### .HasChildren()

Returns: Whether the UI element has any children

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

&nbsp;

### .ChildrenClear()

Returns: <undefined>

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Removes all children.

&nbsp;

### .ParentChange(newParent)

Returns: <undefined>

| Argument Name | Datatype  | Purpose               |
|---------------|-----------|-----------------------|
| `newParent`   | UI struct | New parent to move to |

&nbsp;

## Element Interaction

### .GetHover()

Returns: Whether the UI element is being highlighted by the pointer

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

&nbsp;

### .GetFocus()

Returns: Whether the UI element is being focused by the UI system

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

N.B. This method will likely get removed in the near future.

&nbsp;

### .GetButton(buttonName)

Returns: Whether the UI element is being focused by the UI system

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

N.B. This method will likely get removed in the near future.

&nbsp;

### .HoverStateSet(state)

Returns: <undefined>

| Argument Name | Datatype | Purpose      |
|---------------|----------|--------------|
| state         | boolean  | State to set |

&nbsp;

### .ButtonStateSet(buttonName, state)

Returns: <undefined>

| Argument Name | Datatype | Purpose                                  |
|---------------|----------|------------------------------------------|
| `buttonName`  | string   | Name of the button to set this state for |
| `state`       | boolean  | State to set                             |

&nbsp;

## Search

### .Find(identifier)

Returns: UI element descendent with the given identifier, or <undefined> if it could not be found

| Argument Name | Datatype | Purpose                                     |
|---------------|----------|---------------------------------------------|
| `identifier`  | string   | Identifier of the UI element to try to find |

This is a recursive downwards search so any descendent (i.e. any UI element with the scoped element
as an ancestor) UI element with a matching identifier is returned.

&nbsp;

### .FindType(resultArray, type)

Returns: <undefined>

| Argument Name | Datatype | Purpose                              |
|---------------|----------|--------------------------------------|
| `resultArray` | array    | Array to push found UI elements into |
| `type`        | string   | Type of UI element to find           |

This is a recursive downwards search so any descendent (i.e. any UI element with the scoped element
as an ancestor) UI element with a matching type is pushed into the array.

&nbsp;

### .ReplaceFromFile(filePath)

Returns: <undefined>

| Argument Name | Datatype | Purpose                                                            |
|---------------|----------|--------------------------------------------------------------------|
| `filePath`    | string   | Path to the BentoScript to execute and replace the UI element with |

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
