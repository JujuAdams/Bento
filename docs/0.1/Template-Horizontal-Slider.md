# Horizontal Slider Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoHorizontalSlider</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassHorizontalSlider</code></td>
    </tr>
</table>

A horizontal slider.

Sliders have two special callbacks, `callbackOnValueChange` and `callbackValueUpdate`:

`callbackOnValueChange` is executed when the handle is moved by the player. You could use this callback to set a variable elsewhere or to play a sound etc. `callbackValueUpdate` is called once when the slider is created, and then every frame. The intention is that this callback allows you to create a two-way binding for the slider. The function you set for `callbackValueUpdate` should return  the value you want to set for the slider. For example:

```
build BentoHorizontalSlider {
    onValueChange = fn {
        SettingsSet("sound volume", value)
        AudioPlay(snd_blip)
    }

    valueUpdate = fn {
        return SettingsGet("sound volume")
    }
}
```

&nbsp;

## Variables

| Name                    | Datatype | Purpose                                                                           |
|-------------------------|----------|-----------------------------------------------------------------------------------|
| `color`                 | RGB      | Colour for the slider                                                             |
| `alpha`                 | number   | Alpha blending value                                                              |
| `handleWidth`           | number   | Width of the handle                                                               |
| `handleHeight`          | number   | Height of the handle                                                              |
| `handlePosition`        | number   | Normalised (0 -> 1) position of the handle. Coupled to the `.value` variable      |
| `value`                 | number   | Value for the slider. Coupled to the `.handlePosition` variable                   |
| `valueMin`              | number   | Minimum value when the handle is at the left-hand side                            |
| `valueMax`              | number   | Maximum value when the handle is at the right-hand side                           |
| `valueIncrement`        | boolean  | Quantisation resolution for the slider value                                      |
| `callbackOnValueChange` | function | Callback to execute when the handle of the slider is moved                        |
| `callbackValueUpdate`   | function | Callback to execute every frame to link the slider to a variable stored elsewhere |

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