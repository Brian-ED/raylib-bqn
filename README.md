# raylib-bqn, a raylib binding for BQN
raylib-bqn is a [binding](https://en.wikipedia.org/wiki/Language_binding) to [raylib](https://github.com/raysan5/raylib), meaning all values and functions defined in raylib are exposed to BQN.
If you need documentation on how to use the functions in raylib-bqn, look in [raylib](https://github.com/raysan5/raylib).
One exception to the raylib documentation is that for BQN I would recommend users to never use relative paths. This is because paths are always relative to raylib.bqn.

## Using in a bqn script
Simply [import](https://mlochbaum.github.io/BQN/spec/system.html#scripts) `raylib.bqn`, with a left argument of the path to the raylib binary.
Examples:
`⟨"path/to/raylib.so"⟩ •Import "path/to/raylib.bqn"`
`⟨"raylib.dll"⟩ •Import "raylib.bqn"`

## Example

```BQN
pathToLib ← •file.RealPath "libraylib.so"
rl ← ⟨pathToLib⟩ •Import "../raylib.bqn"

rl.InitWindow 200‿200‿"hello!"
rl.SetTargetFPS 60
{𝕊:
  rl.BeginDrawing⟨⟩
    rl.ClearBackground 0‿0‿0‿0
    rl.DrawFPS 0‿0
  rl.EndDrawing⟨⟩
}•_while_(¬rl.WindowShouldClose∘⟨⟩)@

rl.CloseWindow⟨⟩
```

## Extra information
`raylib.bqn` should always be latest version of raylib. Updates to this repository may lead to updating raylib, but this repository will always be only for major versions of raylib.

`raylib.bqn` was generated automatically using [c-header-to-bqn-ffi](https://github.com/Brian-ED/c-header-to-bqn-ffi/).

[rayed-bqn](https://github.com/Brian-ED/rayed-bqn) is an attempt at re-designing some of raylib to be more inline with BQN.
