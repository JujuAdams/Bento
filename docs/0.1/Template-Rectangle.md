# Rectangle Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoRectangle</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassRectangle</code></td>
    </tr>
</table>

A basic rectangle. Useful for whiteboxing or creating semi-transparent masks.

&nbsp;

## Variables

| Name          | Datatype | Purpose                          |
|---------------|----------|----------------------------------|
| `borderColor` | RGB      | Colour of the border             |
| `borderAlpha` | number   | Alpha transparency of the border |
| `fillColor`   | RGB      | Colour of the rectangle fill     |
| `fillAlpha`   | number   | Alpha transparency of the fill   |

&nbsp;

## Methods

No additional methods beyond shared methods.

&nbsp;

## Examples

### Red

Rectangles are meant to be used for wireframing user interfaces. It can be helpful to colour-code rectangles so that you can better visualise the structure of your layout.

<!-- tabs:start -->

#### **BentoScript**

```
build BentoRectangle {
    borderColor = c_red
    borderAlpha = 1
    fillColor   = c_maroon
    fillAlpha   = 0.5
}
```

#### **GML**

```
with(new BentoClassRectangle())
{
	BentoOpen(self);
	    Set("borderColor", c_red);
	    Set("borderColor", 1);
	    Set("fillAlpha",   c_maroon);
	    Set("fillAlpha",   0.5);
	BentoClose();
}
```

<!-- tabs:end -->