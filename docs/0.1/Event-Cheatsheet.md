# Shared Events

&nbsp;

?> This page is a brief cheatsheet. More details on events can be found [here](Events).

&nbsp;

The variables and methods on this page define events and are available across all UI elements.

&nbsp;

## General

| Scripting Name | GML Function   | Purpose                                                                                    |
|----------------|----------------|--------------------------------------------------------------------------------------------|
| `eventStep`    | `EventStep`    | Called via `BentoStep()`                                                                   |
| `eventDraw`    | `EventDraw`    | Called via `BentoDraw()`                                                                   |
| `eventOnClose` | `EventOnClose` | Called when a UI element finishes construction (i.e. at the final closing } curly bracket) |
| `eventBuildIn` | `EventBuildIn` | Called when a UI element is when appearing on screen a.k.a. "building in"                  |

&nbsp;

## Button / Clicking

Button events require one of the following variables to be set:

| Variable Name   | Datatype        | Purpose                                                                                                                                    |
|-----------------|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| `targetListen`  | string or array | What button names this UI element can receive when the button is directly clicked on. Use an array for sensitivity to muliple button names |
| `castListen`    | string or array | What button names this UI element can receive by casting. Use an array for sensitivity to muliple button names                             |

| Scripting Name    | GML Function            | Purpose                                                                                                                                                |
|-------------------|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `eventClick`      | `EventButtonClick`      | Function to call when a button is deliberately actived (typically by clicking on it!). This function is also triggered by button casts                 |
| `eventPress`      | `EventButtonStart`      | Function to call when a button is pressed on the UI element                                                                                            |
| `eventHold`       | `EventButton`           | Function to call when a button is held on the UI element                                                                                               |
| `eventRelease`    | `EventButtonEnd`        | Function to call when a button is released (and the UI element received a pressed event) <br> **N.B.** This is NOT the same as "clicking" the button. A button can be released for many reasons that aren't the same as the player deliberately clicking |
| `eventCanCapture` | `EventButtonCanCapture` | Function to call to check whether a UI element can be clicked. The function should return <true> or <false> to indicate clickability                   |

&nbsp;

## Pointer-Over / Highlight

| Scripting Name      | GML Function        | Purpose                                                                                                                    |
|---------------------|---------------------|----------------------------------------------------------------------------------------------------------------------------|
| `eventEnter`        | `EventHoverStart`   | Function to call when the pointer enters the UI element, or when the UI element is newly highlighted through gamepad input |
| `eventOver`         | `EventHover`        | Function to call when the UI element is highlighted                                                                        |
| `eventLeave`        | `EventHoverEnd`     | Function to call when the UI element is un-highlighted                                                                     |
| `eventCanHighlight` | `EventCanHighlight` | Function to call to check whether a UI element can be highlighted                                                          |

&nbsp;

## Slider

| Scripting Name       | GML Function         | Purpose                                                                                                                                         |
|----------------------|----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| `eventOnValueChange` | `EventOnValueChange` | Function to call when the slider's handle is moved. Can be used to set another variable or trigger other behaviour                              |
| `eventValueUpdate`   | `EventValueUpdate`   | Function to call, every frame, to update the slider's value. Best used in conjunction with the above event to create a two-way variable binding |

&nbsp;

## Layout

| Scripting Name     | GML Function         | Purpose                                                                                                                                                                                       |
|--------------------|----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `eventLayout`      | `EventLayoutExecute` | Manual use only. This function is called to determine the position of a UI element when completing its construction                                                                           |
| `eventLayoutCheck` | `EventLayoutCheck`   | Manual use only and very optional. This function is called after laying out child element to verify that they've been placed correctly. The event should return <true> or <false> accordingly |