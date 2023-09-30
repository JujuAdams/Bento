# Sprite Button Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoSpriteButton</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassSpriteButton</code></td>
    </tr>
</table>

A button drawn using a sprite. When interacted with, the sprite can change image/color etc.

Don't forget to set the `.targetListen` and `.click variables`! Buttons will be highlightable but won't do anything if you don't set **both** variables. For example:

```
build BentoSpriteButton {
    //Receive events from the left mouse button
    targetListen = "action"
    
    //Then tell the UI system what to do when we're clicked
    click = fn {
        Log("Ping!")
    }
}
```

&nbsp;

## Variables

| Name          | Datatype | Purpose                                                                                                              |
|---------------|----------|----------------------------------------------------------------------------------------------------------------------|
| `sprite`      | sprite   | Sprite to draw when in a neutral state. You may use a string if `BentoDebugRelaxedSprites()` to set to `true`<br> N.B. Setting the sprite will also set the width/height of the UI element itself |
| `image`       | number   | Image of the sprite to draw when in a neutral state                                                                  |
| `color`       | RGB      | Blend color for the button when in a neutral state                                                                   |
| `hoverSprite` | sprite   | Sprite to draw when the button is highlighted. You may use a string if `BentoDebugRelaxedSprites()` to set to `true` |
| `hoverImage`  | number   | Image of the sprite to draw when the button is highlighted                                                           |
| `hoverColor`  | RGB      | Blend color for the button when highlighted                                                                          |
| `heldSprite`  | sprite   | Sprite to draw when the button is pressed. You may use a string if `BentoDebugRelaxedSprites()` to set to `true`     |
| `heldImage`   | number   | Image of the sprite to draw when the button is pressed                                                               |
| `heldColor`   | RGB      | Blend color for the button when pressed                                                                              |
| `alpha`       | number   | Alpha transparency                                                                                                   |
| `stretch`     | boolean  | Whether or not to stretch the sprite over the bounding box                                                           |

&nbsp;

## Methods

No additional methods beyond shared methods.

&nbsp;

## Examples

### Visible

<!-- tabs:start -->

#### **BentoScript**

```

```

#### **GML**

```

```

<!-- tabs:end -->