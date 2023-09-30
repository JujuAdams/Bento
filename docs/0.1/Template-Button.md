# Button Template

&nbsp;

## Details

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>BentoButton</code></td>
    </tr>
    <tr>
		<td><b>GML</b></td>
		<td><code>BentoClassButton</code></td>
    </tr>
</table>

Simple unadorned rectangular button. Useful as a basis for creating custom button behaviour.

Don't forget to set the `.targetListen` and `.click variables`! Buttons will be highlightable but won't do anything if you don't set **both** variables. For example:

```
build BentoButton {
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

| Name    | Datatype | Purpose                    |
|---------|----------|----------------------------|
| `color` | RGB      | Blend color for the button |
| `alpha` | number   | Alpha transparency         |

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