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

GML name: `BentoClassRectangle()` *constructor*

&nbsp;

## Variables

|Name         |Datatype|Purpose                       |
|-------------|--------|------------------------------|
|`borderColor`|colour  |                              |
|`borderAlpha`|number  |                              |
|`fillColor`  |colour  |                              |
|`fillAlpha`  |number  |                              |

&nbsp;

## Methods

No additional methods beyond shared methods.

&nbsp;

## Examples

### Red

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