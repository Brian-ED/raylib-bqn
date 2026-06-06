#!/usr/bin/env bqn
⟨ToFFI⋄ParseHeader⟩ ← •Import "../c-header-to-bqn-ffi/parse.bqn"
headerPaths←("/usr/local/include/"⊣´•args)⊸∾¨"raylib.h"‿"rlgl.h"‿"raymath.h"
badFunctions ← "rlEnableStatePointer"‿"rlDisableStatePointer"
outFile ← "output-raylib.bqn"
renames ← [
  "RL_ZERO"‿"RLGL_VERSION"     ‿"_Bool"
  "RLZERO" ‿"RLGLVersionString"‿"bool"
]
prefixes ← 2‿1/⟨
  "/* Functions defined as 'extern' by default (implicit specifiers)*/"
  "inline /* Functions may be inlined or external definition used*/"
⟩

# Parsing defines because they're removed in the later macro-resolution stage
defines ← ∾´⊑¨prefixes ParseHeader¨ •FChars¨ headerPaths

macrosResolved ← {𝕊:
  err‿out‿errMsg←•SH"cc"‿"-fkeep-system-includes"‿"-E"‿"-CC"‿𝕩
  errMsg!¬err
  out
}¨headerPaths

#         /¯¯¯¯filter bad funcs¯¯¯¯¯\ /¯¯¯¯Mash all parsed data together¯¯¯¯\
ffiData ← (¬badFunctions∊˜⊑¨)⊸/⌾(5⊸⊑) ∾¨´prefixes ParseHeader¨ macrosResolved
#                   /¯¯¯¯¯¯¯¯¯¯Filter dupe names¯¯¯¯¯¯¯¯¯¯\ /¯Add back the removed defines
ffi ← renames ToFFI (∊⊑¨)⊸/⌾⊑ (∊⊑¨)⊸/⌾(1⊸⊑) (∊1⊸⊑¨)⊸/⌾(2⊸⊑) (Defines⟨⟩⁼)⌾⊑ ffiData

outFile •FChars ffi
•Out outFile∾" successfully generated"
