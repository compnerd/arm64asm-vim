" vim: set et ft=vim sw=2 sts=2 ts=8 tw=80 :
" Script:   arm64asm.vim
" Author:   Saleem Abdulrasool <compnerd@compnerd.org>
" Homepage: http://github.com/compnerd/arm64asm
" Requires: Vim 7
" License:  Redistribute under the same terms as Vim itself
" Purpose:  ARM64 Assembly Syntax Highlighting

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" NOTE(compnerd) '.' is not in the default keyword, and will cause the
" directives to not be recognised by default.  Also add '!' to ensure that the
" increment operator is matched.
if version < 600
  set iskeyword=!,#,$,%,.,48-57,:,;,=,@,_
else
  setlocal iskeyword=!,#,$,.,48-57,:,;,=,@,_
endif

syntax case match

syntax keyword AArch64Special NOTE TODO XXX contained

syntax case ignore

syntax region AArch64Comment start="//" end="$" keepend contains=AArch64Special
syntax region AArch64Comment start="/\*" end="\*/" contains=AArch64Special
" MachO uses ; as a comment leader
syntax region AArch64Comment start=";" end="$" contains=todo

syntax keyword AArch64Directive .align .p2align
syntax keyword AArch64Directive .global .globl .type
syntax keyword AArch64Directive .hword .word .xword .long .quad
syntax keyword AArch64Directive .loh
syntax keyword AArch64Directive .tlsdesccall
syntax keyword AArch64Directive .ltorg .pool
syntax keyword AArch64Directive .req .unreq
syntax keyword AArch64Directive .inst
syntax keyword AArch64Directive .private_extern .extern
syntax keyword AArch64Directive .section .text .data
" NOTE(compnerd) .type is already listed above
syntax keyword AArch64Directive .def .endef .scl
syntax keyword AArch64Directive .macro .endmacro .endm
syntax keyword AArch64Directive .set
syntax keyword AArch64Directive .if .else .endif
syntax keyword AArch64Directive .fill

syntax match AArch64Modifier /:lo12:/ contained
syntax match AArch64Modifier /:abs_g3:/ contained
syntax match AArch64Modifier /:abs_g2:/ contained
syntax match AArch64Modifier /:abs_g2_s:/ contained
syntax match AArch64Modifier /:abs_g2_nc:/ contained
syntax match AArch64Modifier /:abs_g1:/ contained
syntax match AArch64Modifier /:abs_g1_s:/ contained
syntax match AArch64Modifier /:abs_g1_nc:/ contained
syntax match AArch64Modifier /:abs_g0:/ contained
syntax match AArch64Modifier /:abs_g0_s:/ contained
syntax match AArch64Modifier /:abs_g0_nc:/ contained
syntax match AArch64Modifier /:dtprel_g2:/ contained
syntax match AArch64Modifier /:dtprel_g1:/ contained
syntax match AArch64Modifier /:dtprel_g1_nc:/ contained
syntax match AArch64Modifier /:dtprel_g0:/ contained
syntax match AArch64Modifier /:dtprel_g0_nc:/ contained
syntax match AArch64Modifier /:dtprel_hi12:/ contained
syntax match AArch64Modifier /:dtprel_lo12:/ contained
syntax match AArch64Modifier /:dtprel_lo12_nc:/ contained
syntax match AArch64Modifier /:tprel_g2:/ contained
syntax match AArch64Modifier /:tprel_g1:/ contained
syntax match AArch64Modifier /:tprel_g1_nc:/ contained
syntax match AArch64Modifier /:tprel_g0:/ contained
syntax match AArch64Modifier /:tprel_g0_nc:/ contained
syntax match AArch64Modifier /:tprel_hi12:/ contained
syntax match AArch64Modifier /:tprel_lo12:/ contained
syntax match AArch64Modifier /:tprel_lo12_nc:/ contained
syntax match AArch64Modifier /:tlsdesc:/ contained
syntax match AArch64Modifier /:tlsdesc_lo12:/ contained
syntax match AArch64Modifier /:got:/ contained
syntax match AArch64Modifier /:got_lo12:/ contained
syntax match AArch64Modifier /:gottprel:/ contained
syntax match AArch64Modifier /:gottprel_lo12:/ contained
syntax match AArch64Modifier /:gottprel_g1:/ contained
syntax match AArch64Modifier /:gottprel_g0_nc:/ contained

syntax match AArch64Modifier /@PAGE/ contained
syntax match AArch64Modifier /@PAGEOFF/ contained

syntax match AArch64Identifier /[-_$.A-Za-z0-9]\+/
syntax match AArch64Identifier /:.*:[-_$.A-Za-z0-9]\+/ contains=AArch64Modifier
" MachO uses @modifiers
syntax match AArch64Identifier /[-_$.A-Za-z0-9]\+@[a-zA-Z]\+/ contains=AArch64Modifier
" MachO uses L for the PrivateGloablPrefix, ELF uses .L
syntax match AArch64Identifier /\.\?L[-_$.A-Za-z0-9]\+/ contains=AArch64Modifier
syntax match AArch64Identifier /:.*:\.\?L[-_$.A-Za-z0-9]\+/ contains=AArch64Modifier
" MachO uses @modifiers
syntax match AArch64Identifier /\.\?L[-_$.A-Za-z0-9]\+[a-zA-Z]\+/ contains=AArch64Modifier

syntax match AArch64Label /^[-_$.A-Za-z0-9]\+\s*:/
" MachO uses L for the PrivateGloablPrefix, ELF uses .L
syntax match AArch64Label /^\.\?L[-_$.A-Za-z0-9]\+\s*:/
syntax match AArch64Label /^"[-_$.A-Za-z0-9 ]\+\s*":/

syntax keyword AArch64Mnemonic ADC ADCS ADD ADDS ADR ADRP AND ANDS ASR ASRV AT

syntax keyword AArch64Mnemonic BEQ BNE BCS BHS BCC BLO BMI BPL BVS BVC BHI BLS
syntax keyword AArch64Mnemonic BGE BLT BGT BLE BAL BNV
syntax keyword AArch64Mnemonic B.EQ B.NE B.CS B.HS B.CC B.LO B.MI B.PL B.VS B.VC
syntax keyword AArch64Mnemonic B.HI B.LS B.GE B.LT B.GT B.LE B.AL B.NV
syntax keyword AArch64Mnemonic B BFI BFM BFXIL BIC BICS BL BLR BR BRK

syntax keyword AArch64Mnemonic CBNZ CBZ CCMN CINC CINV CLREX CLS CLZ CMN CMP
syntax keyword AArch64Mnemonic CNEG CRC32B CRC32H CRC32W CRC32X CRC32CB CRC32CH
syntax keyword AArch64Mnemonic CRC32CW CRC32CX
syntax keyword AArch64Mnemonic CSEL CSET CSINC CSINV CSNEG

syntax keyword AArch64Mnemonic DC DCPS1 DCPS2 DCP3 DMB DRPS DSB

syntax keyword AArch64Mnemonic EON EOR ERET EXTR

syntax keyword AArch64Mnemonic HINT HLT HVC

syntax keyword AArch64Mnemonic IC ISB

syntax keyword AArch64Mnemonic LDAR LDARB LDARH LDAXP LDAXR LDAXRB LDAXRH LDNP
syntax keyword AArch64Mnemonic LDP LDPSW LDR LDRB LDRH LDRSH LDRSW LDTR LDTRB
syntax keyword AArch64Mnemonic LDTRH LDTRSB LDTRSH LDTRSW LDUR LDURB LDURH
syntax keyword AArch64Mnemonic LDURSB LDURSH LDURSW LDXP LDXR LDXRB LDXRH LSL
syntax keyword AArch64Mnemonic LSLV LSR LSRV

syntax keyword AArch64Mnemonic MADD MNEG MOV MOVK MOVN MOVZ MRS MSUB MUL MVN

syntax keyword AArch64Mnemonic NEGS NGC NGCS NOP

syntax keyword AArch64Mnemonic ORN ORR

syntax keyword AArch64Mnemonic PRFM PRFUM

syntax keyword AArch64Mnemonic RBIT RET REV REV16 REV32 ROR RORV

syntax keyword AArch64Mnemonic SBC SBCS SBFIZ SBFM SBFX SDIV SEV SEVL SMADDL
syntax keyword AArch64Mnemonic SMC SMNEGL SMSUBL SMULH SMULL STLR STLRB STLRH
syntax keyword AArch64Mnemonic STLXP STLXR STLXRB STLXRH XTNP STP STR STRB STRH
syntax keyword AArch64Mnemonic STTTR STTRB STTRH STUR STURB STURH STXP STXR
syntax keyword AArch64Mnemonic STXRB STXRH SUB SUBS SVC SXTB SXTH SXTW SYS SYSL

syntax keyword AArch64Mnemonic TBNZ TBZ TLBI TST

syntax keyword AArch64Mnemonic UBFIZ UBFM UBFX UDIV UMADDL UMNEGL UMSUBL UMULH
syntax keyword AArch64Mnemonic UMULL UXTB UXTH

syntax keyword AArch64Mnemonic WFE WFI

syntax keyword AArch64Mnemonic YIELD

syntax keyword AArch64Mnemonic ABS ADD ADDHN ADDHN2 ADDP ADDV AESD AESE AESIMC
syntax keyword AArch64Mnemonic AESMC AND

syntax keyword AArch64Mnemonic BIC BIF BIT BSL

syntax keyword AArch64Mnemonic CLS CLZ CMEQ CMGE CMGT CMHI CMHS CMLE CMLT CMTST
syntax keyword AArch64Mnemonic CNT

syntax keyword AArch64Mnemonic DUP

syntax keyword AArch64Mnemonic EOR EXT

syntax keyword AArch64Mnemonic FABD FABS FACGE FACGT FADD FADDP FCCMP FCCMPE
syntax keyword AArch64Mnemonic FCMEQ FCMGE FCMGT FCMLE FCMLT FCMP FCMPE FCSEL
syntax keyword AArch64Mnemonic FCVT FCVTAS FCVTAU FCVTL FCVTL2 FCVTNS FCVTNU
syntax keyword AArch64Mnemonic FCVTPS FCVTPU FCVTXN FCVTXN2 FCVTZS FCVTZU FDIV
syntax keyword AArch64Mnemonic FMADD FMAX FMAXNM FMAXMP FMAXNMV FMAXP FMAXV FMIN
syntax keyword AArch64Mnemonic FMINNM FMINNMP FMINNMV FMINP FMINV FMLA FMLS FMOV
syntax keyword AArch64Mnemonic FMSUB FMUL FMULX FNEG FNMADD FNMSUB FNMUL FRECPE
syntax keyword AArch64Mnemonic FRECPS FRECPX FRINTA FRINTI FRINTM FRINTN FRINTP
syntax keyword AArch64Mnemonic FRINTX FRINTX FRINTZ FRSQRTE FRSQRTS FSQRT FSUB

syntax keyword AArch64Mnemonic INS

syntax keyword AArch64Mnemonic LD1 LD1R LD2 LD2R LD3 LD3R LD4 LD4R LDNP LDP LDR
syntax keyword AArch64Mnemonic LDUR

syntax keyword AArch64Mnemonic MLA MLS MOV MOVI MUL MVN MVNI

syntax keyword AArch64Mnemonic NEG NOT

syntax keyword AArch64Mnemonic ORN ORR

syntax keyword AArch64Mnemonic PMUL PMULL PMULL2

syntax keyword AArch64Mnemonic RBIT REV16 REV32 REV64 RSHRN RSHRN2 RSUBHN
syntax keyword AArch64Mnemonic RSUBHN2

syntax keyword AArch64Mnemonic SABA SABAL SABAL2 SABD SABDL SABDL2 SADALP SADDL
syntax keyword AArch64Mnemonic SADDL2 SADDLP SADDLV SADDW SADDW2 SCVTF SHA1C
syntax keyword AArch64Mnemonic SHA1H SHA1M SHA1P SHA1SU0 SHA1SU1 SHA256H2
syntax keyword AArch64Mnemonic SHA256H SHA256SU0 SHA256SU1 SHADD SHL SHLL SHLL2
syntax keyword AArch64Mnemonic SHRN SHRN2 SHSUB SLI SMAX SMAXP SMAXV SMIN SMINP
syntax keyword AArch64Mnemonic SMINV SMLAL SMLAL2 SMLSL SMLSL2 SMOV SMULL SMULL2
syntax keyword AArch64Mnemonic SQABS SQADD SQDMLAL SQDMLAL2 SQDMLSL SQDMLSL2
syntax keyword AArch64Mnemonic SQDMULH SQDMULL SQDMULL2 SQNEG SQRDMULH SQRSHL
syntax keyword AArch64Mnemonic SQRSHRN SQRSHRN2 SQSHL SQSHLU SQSHRN SQSHRN2
syntax keyword AArch64Mnemonic SQSUB SQXTN SQXTN2 SQXTUN SQXTUN2 SHRADD SRI
syntax keyword AArch64Mnemonic SRSHL SRSHR SRSRA SSHL SSHLL SSHLL2 SSHHR SSRA
syntax keyword AArch64Mnemonic SSUBL SSUBL2 SSUBW SSUBW2 ST1 ST2 ST3 ST4 STNP
syntax keyword AArch64Mnemonic STP STR STUR SUB SUBHN SUBHN2 SUQADD SXTL

syntax keyword AArch64Mnemonic TBL TBX TRN1 TRN2

syntax keyword AArch64Mnemonic UABA UABAL UABAL2 UABD UABDL UABDL2 UADALP UADDL
syntax keyword AArch64Mnemonic UADDL2 UADDLP UADDLV UADDW UADDW2 UCVTF UHADD
syntax keyword AArch64Mnemonic UHSUB UMAX UMAXP UMAXV UMIN UMINP UMINV UMLAL
syntax keyword AArch64Mnemonic UMLAL2 UMLSL UMLSL2 UMOV UMULL UMULL2 UQADD
syntax keyword AArch64Mnemonic UQRSHL UQRSHRN UQRSHRN2 UQSHL UQSHRN UQSUB UQXTN
syntax keyword AArch64Mnemonic UQXTN2 URECPE URHADD URSHL URSHR URSQRTE URSRA
syntax keyword AArch64Mnemonic USHL USHLL USHLL2 USHR USQADD USRA USUBL USUBL2
syntax keyword AArch64Mnemonic USUBW USUBW2 UXTL UZP1 UZP2

syntax keyword AArch64Mnemonic XTN XTN2

syntax keyword AArch64Mnemonic ZIP1 ZIP2

syntax match AArch64Macro  /#[_a-zA-Z][_a-zA-Z0-9]*/
syntax match AArch64Number /#-\?\d\+/
syntax match AArch64Number /#([^)]\+)/
" TODO(compnerd) add floating point and hexadecimal numeric literal

" NOTE(compnerd) this must be matched after numerics
syntax match AArch64Label /\d\{1,2\}[:fb]/

syntax keyword AArch64Operator ! ==

syntax keyword AArch64Register  w0  w1  w2  w3  w4  w5  w6  w7  w8  w9 w10
syntax keyword AArch64Register w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 w20
syntax keyword AArch64Register w20 w21 w22 w23 w24 w25 w26 w27 w28 w29 w30
syntax keyword AArch64Register w31

syntax keyword AArch64Register  x0  x1  x2  x3  x4  x5  x6  x7  x8  x9 x10
syntax keyword AArch64Register x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
syntax keyword AArch64Register x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30
syntax keyword AArch64Register x31

syntax keyword AArch64Register  v0  v1  v2  v3  v4  v5  v6  v7  v8  v9 v10
syntax keyword AArch64Register v10 v11 v12 v13 v14 v15 v16 v17 v18 v19 v20
syntax keyword AArch64Register v20 v21 v22 v23 v24 v25 v26 v27 v28 v29 v30
syntax keyword AArch64Register v31

syntax keyword AArch64Register  q0  q1  q2  q3  q4  q5  q6  q7  q8  q9 q10
syntax keyword AArch64Register q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20
syntax keyword AArch64Register q20 q21 q22 q23 q24 q25 q26 q27 q28 q29 q30
syntax keyword AArch64Register q31

syntax keyword AArch64Register  d0  d1  d2  d3  d4  d5  d6  d7  d8  d9 d10
syntax keyword AArch64Register d10 d11 d12 d13 d14 d15 d16 d17 d18 d19 d20
syntax keyword AArch64Register d20 d21 d22 d23 d24 d25 d26 d27 d28 d29 d30
syntax keyword AArch64Register d31

syntax keyword AArch64Register  s0  s1  s2  s3  s4  s5  s6  s7  s8  s9 s10
syntax keyword AArch64Register s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20
syntax keyword AArch64Register s20 s21 s22 s23 s24 s25 s26 s27 s28 s29 s30
syntax keyword AArch64Register s31

syntax keyword AArch64Register wzr xzr

syntax keyword AArch64Register sp pc pstate

syntax match AArch64Type /[@%]function/
syntax match AArch64Type /[@%]object/
syntax match AArch64Type /[@%]tls_object/
syntax match AArch64Type /[@%]common/
syntax match AArch64Type /[@%]notype/
syntax match AArch64Type /[@%]gnu_unique_object/

highlight default link AArch64Comment    Comment
highlight default link AArch64Directive  PreProc
highlight default link AArch64Identifier Identifier
highlight default link AArch64Label      Label
highlight default link AArch64Macro      Macro
highlight default link AArch64Mnemonic   Keyword
highlight default link AArch64Modifier   Special
highlight default link AArch64Number     Number
highlight default link AArch64Operator   Operator
highlight default link AArch64Register   StorageClass
highlight default link AArch64Type       Tag
highlight default link AArch64TODO       Todo

let b:current_syntax = "arm64asm"

