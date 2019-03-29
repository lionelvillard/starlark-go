
# Starlark in Go with YAML extensions

This project extends [Starkark in Go](https://github.com/google/starlark-go) with first class YAML support.

## Additional statements

```grammar {.good}
SmallStmt = YamlStmt | ...

YamlStmt = identifier ':' YAMLTail
         | string ':' YAMLTail
         | '-' YAMLTail
```

YAMLTail is a lexical element corresponding to all lines with the same or greater indendation level as `YamlStmt`

### Examples

#### YAML Mapping to dictionary

```python
def func1():
  name: max
  cities:
  - SF
  - LA

print(func1()) # print a dictionary
```

#### YAML Sequence to list

```python
def func():
  - SF city
  - LA city

print(func1()) # print a sequence
```

## Dot expression and dictionary

The [dot expression](https://github.com/google/starlark-go/blob/master/doc/spec.md#dot-expressions)
can be used to get the dictionary value corresponding to the dot expression attribute

```python
def func1():
  name: max
  cities:
  - SF
  - LA

print(func1().name) # print max
```

[Builtin dictionary methods](https://github.com/google/starlark-go/blob/master/doc/spec.md#built-in-methods) take precedence over attribute selection.
For instance, access the attribute `values` by using either [get](https://github.com/google/starlark-go/blob/master/doc/spec.md#dict%C2%B7get)
or an [index](https://github.com/google/starlark-go/blob/master/doc/spec.md#index-expressions).


```python
def func1():
  values: ['1', '2']

print(func1()['values'][0]) # print 1
```

## Enclosed Starlark expression in YAML

YAML text enclosed in curly braces `{ ... }` is interpreted as Starlark [expression](https://github.com/google/starlark-go/blob/master/doc/spec.md#expressions)

```python
def func1(d):
  text: the city name is { d.name }

print(func1({'name': 'NY'}).text) # print the city name is NY
```

### Mapping flow style disambiguation

In YAML, flow mappings are denoted by surrounding '{' and '}' characters.

```python
def func1(d):
  text: { d.name } is big

print(func1({'name': 'NY'}).text) # print an error!
```

You can change this behavior by prefixing `{` with `s`.

```python
def func1(d):
  text: s{ d.name } is big

print(func1({'name': 'NY'}).text) # print NY is big
```

