pathToLib ← •file.RealPath "/usr/local/lib/libraylib.so"
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
