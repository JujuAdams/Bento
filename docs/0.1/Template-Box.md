# Box Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoBox</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassBox</code></td>
    </tr>
</table>

An invisible rectangle used for organising layouts.

&nbsp;

## Variables

No additional variables beyond shared variables.

&nbsp;

## Methods

No additional methods beyond shared methods.

&nbsp;

## Examples

### Visible

Boxes are primarily used to aid layouts so the basic Bento box defaults to being invisible. When wireframing or debugging it's often useful to be able to visualise your boxes. Setting the `visible` variable to `true` will make the box visible, helping you understand your layout.

<!-- tabs:start -->

#### **BentoScript**

```
build BentoBox {
	visible = true
}
```

#### **GML**

```
BentoOpen(new BentoClassBox());
    BentoCurrent().Set("visible", true);
BentoClose();
```

<!-- tabs:end -->