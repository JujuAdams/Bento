# General Variables

## identifier

<!-- tabs:start -->

#### **Summary**

<table>
    <tr>
    	<td><b>Datatype</b></td>
    	<td>string</td>
	</tr>
    <tr>
    	<td><b>Default</b></td>
    	<td>Varies; automatically generated</td>
	</tr>
    <tr>
    	<td><b>Get</b></td>
    	<td>✅</td>
	</tr>
    <tr>
    	<td><b>Set</b></td>
    	<td>✅</td>
	</tr>
</table>

A string used to identify a UI element. This string is automatically generated, but you can opt to redefine it to make finding UI elements (e.g. with the `UiFind()` function) easier. A UI element's `identifier` variable should be unique within a root.

#### **Usage**

```gml
TODO lol
```

<!-- tabs:end -->

&nbsp;

## active

<!-- tabs:start -->

#### **Summary**

<table>
    <tr>
    	<td><b>Datatype</b></td>
    	<td>boolean</td>
	</tr>
    <tr>
    	<td><b>Default</b></td>
    	<td><code>true</code></td>
	</tr>
    <tr>
    	<td><b>Get</b></td>
    	<td>✅</td>
	</tr>
    <tr>
    	<td><b>Set</b></td>
    	<td>✅</td>
	</tr>
</table>

Whether or not the UI element is active and available for use. An inactive UI element cannot be highlighted, focused, or clicked but will still be updated by `UiStep()` and drawn by `UiDraw()`.

#### **Usage**

```gml
TODO lol
```

<!-- tabs:end -->

&nbsp;

## visible

<!-- tabs:start -->

#### **Summary**

<table>
    <tr>
    	<td><b>Datatype</b></td>
    	<td>boolean</td>
	</tr>
    <tr>
    	<td><b>Default</b></td>
    	<td><code>true</code></td>
	</tr>
    <tr>
    	<td><b>Get</b></td>
    	<td>✅</td>
	</tr>
    <tr>
    	<td><b>Set</b></td>
    	<td>✅</td>
	</tr>
</table>

Whether or not the UI element is visible. An invisible UI element cannot be drawn, highlighted, focused, or clicked but will still be updated by `UiStep()`.

#### **Usage**

```gml
TODO lol
```

<!-- tabs:end -->

&nbsp;