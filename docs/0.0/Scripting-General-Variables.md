# General Variables

## identifier

<table>
    <tr>
    	<td align="right">Datatype</td>
    	<td align="right"><code>number</code></td>
	</tr>
    <tr>
    	<td align="right">Default</td>
    	<td align="right">Varies; automatically generated</td>
	</tr>
    <tr>
    	<td align="right">Get</td>
    	<td align="right">✅</td>
	</tr>
    <tr>
    	<td align="right">Set</td>
    	<td align="right">✅</td>
	</tr>
</table>

<!-- tabs:start -->

#### **Description**

A string used to identify a UI element. This string is automatically generated, but you can opt to redefine it to make finding UI elements (e.g. with the `UiFind()` function) easier. A UI element's `identifier` variable should be unique within a root.

#### **Example**

```gml
TODO lol
```

<!-- tabs:end -->

&nbsp;

## active

<table>
    <tr>
    	<td align="right">Datatype</td>
    	<td align="right"><code>boolean</code></td>
	</tr>
    <tr>
    	<td align="right">Default</td>
    	<td align="right"><code>true</code></td>
	</tr>
    <tr>
    	<td align="right">Get</td>
    	<td align="right">✅</td>
	</tr>
    <tr>
    	<td align="right">Set</td>
    	<td align="right">✅</td>
	</tr>
</table>

<!-- tabs:start -->

#### **Description**

Whether or not the UI element is active and available for use. An inactive UI element cannot be highlighted, focused, or clicked but will still be updated by `UiStep()` and drawn by `UiDraw()`.

#### **Example**

```gml
TODO lol
```

<!-- tabs:end -->

&nbsp;

## visible

<table>
    <tr>
    	<td align="right">Datatype</td>
    	<td align="right"><code>boolean</code></td>
	</tr>
    <tr>
    	<td align="right">Default</td>
    	<td align="right"><code>true</code></td>
	</tr>
    <tr>
    	<td align="right">Get</td>
    	<td align="right">✅</td>
	</tr>
    <tr>
    	<td align="right">Set</td>
    	<td align="right">✅</td>
	</tr>
</table>

<!-- tabs:start -->

#### **Description**

Whether or not the UI element is visible. An invisible UI element cannot be drawn, highlighted, focused, or clicked but will still be updated by `UiStep()`.

#### **Example**

```gml
TODO lol
```

<!-- tabs:end -->

&nbsp;