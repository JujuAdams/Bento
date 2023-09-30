# Text Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoText</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassText</code></td>
    </tr>
</table>

A simple text rendering class. The size of the UI element is automatically calculated from the text itself.

&nbsp;

## Variables

| Name     | Datatype | Purpose                                                                                    |
|----------|----------|--------------------------------------------------------------------------------------------|
| `label`  | string   | Text to draw                                                                               |
| `margin` | number   | Additional space to put around the text when calculating the bounding box                  |
| `font`   | string   | Name of the font to use                                                                    |
| `color`  | RGB      | Colour to use when drawing the text                                                        |
| `scale`  | number   | Scaling factor. A value of 1 is no change                                                  |
| `alpha`  | number   | Alpha blending value                                                                       |
| `hAlign` | string   | `"left"` `"center"` or `"right"`. Note that the bounding box calcs are based on `"centre"` |
| `vAlign` | string   | `"top"` `"middle"` or `"bottom"`. Note that the bounding box calcs are based on `"middle"` |

&nbsp;

## Methods

### .Trim()

Returns: N/A (`undefined`)

| Argument Name | Datatype | Purpose |
|---------------|----------|---------|
| None          |          |         |

Resizes the UI element to match the size of the rendered text. Automatically called by this class when the font, label, or margin is changed.

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