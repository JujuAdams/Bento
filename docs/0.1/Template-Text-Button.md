# Text Button Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoTextButton</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassTextButton</code></td>
    </tr>
</table>

Simple clickable text button.

Don't forget to set the `.targetListen` and `.click` variables! Buttons will be highlightable but won't do anything if you don't set **both** variables. For example:

```
build BentoTextButton {
    label = "Example Button"
    
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

| Name     | Datatype | Purpose                                                                   |
|----------|----------|---------------------------------------------------------------------------|
| `label`  | string   | Text to draw                                                              |
| `margin` | number   | Additional space to put around the text when calculating the bounding box |
| `font`   | string   | Name of the font to use                                                   |
| `color`  | RGB      | Colour to use when drawing the button                                     |
| `alpha`  | number   | Alpha blending value                                                      |

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