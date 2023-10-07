# Shared Variables

&nbsp;

The variables on this page are available across all UI elements.

&nbsp;

## Miscellaneous

| Name            | Datatype | Purpose                                                                                                                             |
|-----------------|----------|-------------------------------------------------------------------------------------------------------------------------------------|
| `identifier`    | string   | Unique identifier for the UI element. Automatically generated. You can set this to something yourself to make UI referencing easier |
| `active`        | boolean  | Whether or not the UI element is actively receives player input                                                                     |
| `visible`       | boolean  | Whether or not the UI element is visible. An invisible UI also doesn't receive player input                                         |
| `focusable`     | boolean  | Whether this UI element can be focused                                                                                              |
| `layoutInclude` | boolean  | Whether this UI element can be moved around by a parent's layout function                                                           |
| `layoutOrder`   | number   | Where to place this UI element in the layout. A higher number will place the UI element later, relative to its siblings             |

&nbsp;

## Local Position

| Name      | Datatype | Purpose                                                                                              |
|-----------|----------|------------------------------------------------------------------------------------------------------|
| `left`    | number   | Left x-position of the UI element, relative to the top-left corner of the parent UI element          |
| `top`     | number   | Top y-position of the UI element, relative to the top-left corner of the parent UI element           |
| `right`   | number   | Right x-position of the UI element, relative to the top-left corner of the parent UI element         |
| `bottom`  | number   | Bottom y-position of the UI element, relative to the top-left corner of the parent UI element        |
| `ltrb`    | array    | Convenient 4-element array that represents the left/top/right/bottom coordinates (see above)         |
| `x`       | number   | x-position of the centre of the UI element, relative to the top-left corner of the parent UI element |
| `y`       | number   | y-position of the middle of the UI element, relative to the top-left corner of the parent UI element |
| `width`   | number   | Width of the UI element                                                                              |
| `height`  | number   | Height of the UI element                                                                             |
| `xy`      | array    | Convenient 2-element array that represents the x/y coordinates (see above)                           |
| `xywh`    | array    | Convenient 4-element array that represents the x/y/width/height coordinates (see above)              |
| `originX` | number   | Normalised (from 0 to 1) origin point in the x-axis. A value of 0.5 is central                       |
| `originY` | number   | Normalised (from 0 to 1) origin point in the y-axis. A value of 0.5 is central                       |
| `origin`  | array    | Convenient 2-element array that represents the normalised origin (see above)                         |
| `scale`   | number   | Scale of the UI element. A value of 1 is no change                                                   |
| `size`    | array    | Convenient 2-element array that represents the width/height values (see above)                       |

&nbsp;

## Children

| Name             | Datatype  | Purpose                                                                                                            |
|------------------|-----------|--------------------------------------------------------------------------------------------------------------------|
| `parent`         | UI struct | Parent for the UI element                                                                                          |
| `children`       | array     | Array of child UI elements                                                                                         |
| `childMinLeft`   | number    | Furtherest left x-coordinate amongst child UI elements, relative to the top-left corner of the scoped UI element   |
| `childMinTop`    | number    | Furtherest top y-coordinate amongst child UI elements, relative to the top-left corner of the scoped UI element    |
| `childMaxRight`  | number    | Furtherest right x-coordinate amongst child UI elements, relative to the top-left corner of the scoped UI element  |
| `childMaxBottom` | number    | Furtherest bottom y-coordinate amongst child UI elements, relative to the top-left corner of the scoped UI element |

&nbsp;

## World Position

| Name          | Datatype | Purpose                                                                                              |
|---------------|----------|------------------------------------------------------------------------------------------------------|
| `worldLeft`   | number   | Left x-position of the UI element, relative to the top-left corner of the GUI (game window)          |
| `worldTop`    | number   | Top y-position of the UI element, relative to the top-left corner of the GUI (game window)           |
| `worldRight`  | number   | Right x-position of the UI element, relative to the top-left corner of the GUI (game window)         |
| `worldBottom` | number   | Bottom y-position of the UI element, relative to the top-left corner of the GUI (game window)        |
| `worldX`      | number   | x-position of the centre of the UI element, relative to the top-left corner of the GUI (game window) |
| `worldY`      | number   | y-position of the middle of the UI element, relative to the top-left corner of the GUI (game window) |
| `worldWidth`  | number   | Width of the UI element in world space                                                               |
| `worldHeight` | number   | Height of the UI element in world space                                                              |

&nbsp;

## Draw Position
                                                                                                                                                
| Name         | Datatype | Purpose                                                                                                                       |
|--------------|----------|-------------------------------------------------------------------------------------------------------------------------------|
| `drawLeft`   | number   | Left x-position of where the UI element should be drawn. This accounts for offsets due to scroll boxes and animation          |
| `drawTop`    | number   | Top y-position of where the UI element should be drawn. This accounts for offsets due to scroll boxes and animation           |
| `drawRight`  | number   | Right x-position of where the UI element should be drawn. This accounts for offsets due to scroll boxes and animation         |
| `drawBottom` | number   | Bottom y-position of where the UI element should be drawn. This accounts for offsets due to scroll boxes and animation        |
| `drawX`      | number   | x-position of the centre of where the UI element should be drawn. This accounts for offsets due to scroll boxes and animation |
| `drawY`      | number   | y-position of the middle of where the UI element should be drawn. This accounts for offsets due to scroll boxes and animation |
| `drawWidth`  | number   | Width of the UI element                                                                                                       |
| `drawHeight` | number   | Height of the UI element                                                                                                      |

&nbsp;

## Gamepad/Keyboard navigation

| Name              | Datatype  | Purpose                                                                           |
|-------------------|-----------|-----------------------------------------------------------------------------------|
| `navigationLock`  | boolean   | Whether to prevent "free search" gamepad/keyboard navigation from this UI element |
| `navigationRight` | UI struct | UI element to navigate to when pushing right                                      |
| `navigationUp`    | UI struct | UI element to navigate to when pushing up                                         |
| `navigationLeft`  | UI struct | UI element to navigate to when pushing left                                       |
| `navigationDown`  | UI struct | UI element to navigate to when pushing down                                       |

&nbsp;

## Manual Animation

!> If you're using the `Animate*()` methods then you don't need to touch these variables.

| Name               | Datatype | Purpose                                                               |
|--------------------|----------|-----------------------------------------------------------------------|
| `animXOffset`      | number   | Visual x-offset for the UI element. A value of 0 represents no offset |
| `animYOffset`      | number   | Visual y-offset for the UI element. A value of 0 represents no offset |
| `animScale`        | number   | Currently inactive.                                                   |
| `animAlpha`        | number   | Alpha blend multiplier. A valuie of 1 represents no change            |
| `animBlend`        | number   | Colour to blend to based on the blend factor (see below)              |
| `animBlendAmount`  | number   | Blend factor. A value of 0 represents no change                       |
