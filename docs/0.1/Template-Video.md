# Video Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoVideo</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassVideo</code></td>
    </tr>
</table>

Video playback using GameMaker's native player. The video is drawn stretched across the bounding box.

&nbsp;

## Variables

| Name   | Datatype | Purpose                              |
|--------|----------|--------------------------------------|
| color  | RGB      | Blend color for the video surface    |
| alpha  | number   | Alpha transparency                   |
| source | string   | Path to the video file to play       |
| loop   | boolean  | Whether or not the video should loop |

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