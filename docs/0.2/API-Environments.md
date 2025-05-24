# Environments

&nbsp;

## …Create

`BentoEnvironmentCreate(name)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name  |Datatype|Purpose                     |
|------|--------|----------------------------|
|`name`|string  |Name for the new environment|

!> Environment names must be globally unique.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …Destroy

`BentoEnvironmentDestroy(environment)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name         |Datatype   |Purpose               |
|-------------|-----------|----------------------|
|`environment`|environment|Environment to destroy|

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …Exists

`BentoEnvironmentExists(environmentOrName)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean

|Name               |Datatype             |Purpose                                         |
|-------------------|---------------------|------------------------------------------------|
|`environmentOrName`|environment or string|Environment, or name of an environment, to check|

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …Find

`BentoEnvironmentFind(name)`

<!-- tabs:start -->

#### **Description**

**Returns:** Layer

|Name  |Datatype|Purpose                        |
|------|--------|-------------------------------|
|`name`|string  |Name of the environment to find|

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …TargetPush

`BentoEnvironmentTargetPush(environment)`

<!-- tabs:start -->

#### **Description**

**Returns:** Layer

|Name         |Datatype   |Purpose                                      |
|-------------|-----------|---------------------------------------------|
|`environment`|environment|Environment to set as the current environment|

!> You must call `BentoEnvironmentTargetPop()` for each and every `BentoEnvironmentTargetPush()`.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …TargetPush

`BentoEnvironmentTargetPop(environment)`

<!-- tabs:start -->

#### **Description**

**Returns:** Layer

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
{

}
```

<!-- tabs:end -->