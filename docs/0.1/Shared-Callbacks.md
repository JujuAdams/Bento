# Shared Callbacks

&nbsp;

?> This page is a cheatsheet. More details on callbacks can be found [here](Callbacks).

&nbsp;

The variables and methods on this page define callbacks and are available across all UI elements.

&nbsp;

## General

| Scripting Name    | GML Function         | Purpose                                                                                    |
|-------------------|----------------------|--------------------------------------------------------------------------------------------|
| `callbackStep`    | `CallbackSetStep`    | Called via `BentoStep()`                                                                   |
| `callbackDraw`    | `CallbackSetDraw`    | Called via `BentoDraw()`                                                                   |
| `callbackOnClose` | `CallbackSetOnClose` | Called when a UI element finishes construction (i.e. at the final closing } curly bracket) |
| `callbackBuildIn` | `CallbackSetBuildIn` | Called when a UI element is when appearing on screen a.k.a. "building in"                  |

&nbsp;

## Button / Clicking

Button callbacks require one of the following variables to be set:

| Variable Name   | Datatype        | Purpose                                                                                                                                    |
|-----------------|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| `captureClick`  | string or array | What button names this UI element can receive when the button is directly clicked on. Use an array for sensitivity to muliple button names |
| `captureCast`   | string or array | What button names this UI element can receive by casting. Use an array for sensitivity to muliple button names                             |

| Scripting Name       | GML Function                  | Purpose                                                                                                                                                |
|----------------------|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `callbackClick`      | `CallbackSetButtonClick`      | Function to call when a button is deliberately actived (typically by clicking on it!). This function is also triggered by button casts                 |
| `callbackPress`      | `CallbackSetButtonStart`      | Function to call when a button is pressed on the UI element                                                                                            |
| `callbackHold`       | `CallbackSetButton`           | Function to call when a button is held on the UI element                                                                                               |
| `callbackRelease`    | `CallbackSetButtonEnd`        | Function to call when a button is released (and the UI element received a pressed event) <br> **N.B.** This is NOT the same as "clicking" the button. A button can be released for many reasons that aren't the same as the player deliberately clicking |
| `callbackCanCapture` | `CallbackSetButtonCanCapture` | Function to call to check whether a UI element can be clicked. The function should return <true> or <false> to indicate clickability                   |

&nbsp;

## Pointer-Over / Highlight

| Scripting Name         | GML Function              | Purpose                                                                                                                    |
|------------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------|
| `callbackEnter`        | `CallbackSetHoverStart`   | Function to call when the pointer enters the UI element, or when the UI element is newly highlighted through gamepad input |
| `callbackOver`         | `CallbackSetHover`        | Function to call when the UI element is highlighted                                                                        |
| `callbackLeave`        | `CallbackSetHoverEnd`     | Function to call when the UI element is un-highlighted                                                                     |
| `callbackCanHighlight` | `CallbackSetCanHighlight` | Function to call to check whether a UI element can be highlighted                                                          |

&nbsp;

## Slider

| Scripting Name          | GML Function               | Purpose                                                                                                                                            |
|-------------------------|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `callbackOnValueChange` | `CallbackSetOnValueChange` | Function to call when the slider's handle is moved. Can be used to set another variable or trigger other behaviour                                 |
| `callbackValueUpdate`   | `CallbackSetValueUpdate`   | Function to call, every frame, to update the slider's value. Best used in conjunction with the above callback to create a two-way variable binding |

&nbsp;

## Layout

| Scripting Name        | GML Function               | Purpose                                                                                                                                                                                          |
|-----------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `callbackLayout`      | `CallbackSetLayoutExecute` | Manual use only. This function is called to determine the position of a UI element when completing its construction                                                                              |
| `callbackLayoutCheck` | `CallbackSetLayoutCheck`   | Manual use only and very optional. This function is called after laying out child element to verify that they've been placed correctly. The callback should return <true> or <false> accordingly |