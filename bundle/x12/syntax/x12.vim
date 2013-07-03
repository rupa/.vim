" Vim Syntax file
" Language: X12 EDI files
" Filenames: *.x12

syntax clear
syntax case ignore

" X12 keywords
syntax keyword X12Keyword ISA
syntax keyword X12Keyword GS
syntax keyword X12Keyword ST
syntax keyword X12Keyword SE
syntax keyword X12Keyword GE
syntax keyword X12Keyword IEA

" this should really be determined from the ISA segment
syntax match X12Delim "\~"
syntax match X12Ops "\*"
syntax match X12Sep "\:"

command -nargs=+ HiLink hi def link <args>
HiLink X12Keyword Identifier
HiLink X12Ops Label
HiLink X12Delim String
HiLink X12Sep   Special

let b:current_syntax = "x12"
