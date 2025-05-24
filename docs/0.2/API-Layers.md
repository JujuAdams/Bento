# Layers

&nbsp;

## …Create

`BentoLayerCreate(name, [environment=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                  |
|---------------|--------|-----------------------------------------------------------------------------------------|
|`name`         |string  |Name for the new layer                                                                   |
|`[environment]`|element |Environment to create the layer inside. If not specified, the current environment is used|

Layer names must be unique per environment.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …Destroy

`BentoLayerDestroy([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name     |Datatype|Purpose                                                           |
|---------|--------|------------------------------------------------------------------|
|`[layer]`|layer   |Layer to destroy. If not specified, the current layer is destroyed|

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …Exists

`BentoLayerExists([layerOrName=current], [environment=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean

|Name           |Datatype       |Purpose                                                                |
|---------------|---------------|-----------------------------------------------------------------------|
|`[layerOrName]`|layer or string|Layer, or name of a layer, to check                                    |
|`[environment]`|element        |Environment to check. If not specified, the current environment is used|

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …Find

`BentoLayerFind(name, [environment=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Layer

|Name           |Datatype|Purpose                                                                |
|---------------|--------|-----------------------------------------------------------------------|
|`name`         |string  |Name of the layer to find                                              |
|`[environment]`|element |Environment to check. If not specified, the current environment is used|

#### **Example**

```gml
{

}
```

<!-- tabs:end -->