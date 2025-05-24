# Basics

&nbsp;

## …CreateObject

`BentoCreateObject(object, [variableStruct], [parent=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** Instance

|Name              |Datatype|Purpose                                                                            |
|------------------|--------|-----------------------------------------------------------------------------------|
|`object`          |object  |Object to use an instance of                                                       |
|`[variableStruct]`|struct  |Variable struct to pass into the instance. If not specified, no struct is passed in|
|`[parent]`        |element |Parent element to place the new element inside of. If not specified, `self` is used|

Creates an instance element using an object and places it inside a parent element.

!> If you call this function outside of the scope of a Bento element then make sure to pass in a valid element to the `parent` parameter.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …Destroy

`BentoDestroy([element=self])`

<!-- tabs:start -->

#### **Description**

**Returns:** Instance

|Name       |Datatype|Purpose                                             |
|-----------|--------|----------------------------------------------------|
|`[element]`|element |Element to destroy. If not specified, `self` is used|

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …SystemStep

`BentoSystemStep()`

<!-- tabs:start -->

#### **Description**

**Returns:** Instance

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Updates environments, layers, and UI elements.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …SystemDraw

`BentoSystemDraw()`

<!-- tabs:start -->

#### **Description**

**Returns:** Instance

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Draws all environments, layers, and elements.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …CreateFromJSON

`BentoCreateFromJSON(json, [parent=self], [metadata])`

<!-- tabs:start -->

#### **Description**

**Returns:** Varies, see below

|Name        |Datatype|Purpose                                                                            |
|------------|--------|-----------------------------------------------------------------------------------|
|`json`      |json    |JSON to instantiate                                                                |
|`[parent]`  |element |Parent element to place the new element inside of. If not specified, `self` is used|
|`[metadata]`|struct  |Metadata to pass into processor functions. If not specified, `undefined` is used   |

Creates a GUI instances based on input JSON data. This function can be used to create multiple instances and define multiple properties for those instances. More information on the expected JSON format can be found in the `GUI JSON Format` note.

This function will return the instance that gets created or, if the root node of the JSON is an array, this function will return the first instance that gets created.

!> If you call this function outside of the scope of a Bento element then make sure to pass in a valid element to the `parent` parameter.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->