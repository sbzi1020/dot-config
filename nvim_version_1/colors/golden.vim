" Maintainer: Fion Li <li.shangzi3@gmail.com>

" Use dark mode
set background=dark

" Reset all current highlight back to default
hi clear

" Reset syntax
if exists('syntax_on')
  syntax reset
endif

" Current colorscheme name
let g:colors_name='golden'

" --------------------------------------------------------
"
" `hi/highlight` accepts the settings below:
"
" * {group_name} - The color settings will be applied to, `:h highlight-group`
" * guifg={foreground_color} - `None` means transparent colors
" * guibg={background_color} - `None` means transparent colors
" * gui={font_style_separated_with_comma} - `underline,bold,italic,NONE`
"
" Tips:
"
"   You can run `:highlight` to print all supported groups (included all installed
"   plugin groups).
"
" --------------------------------------------------------


" --------------------------------------------------------
" Color column vertical bar
hi ColorColumn guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Relative number bar and cursorline
hi LineNr guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CursorLineNr guifg=#ffe64d ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" --------------------------------------------------------
" CursorLine
hi CursorLine guifg=NONE ctermfg=NONE guibg=#2E2E2E ctermbg=60 gui=NONE cterm=NONE

" --------------------------------------------------------
" Cursor for [Normal, Visual, Command] mode
" Cursor for [Insert, Command line Insert, Virual with selection ] mode
hi Cursor1 guifg=#23211b ctermfg=235 guibg=#ACE6FE ctermbg=80 gui=NONE cterm=NONE
hi Cursor2 guifg=#23211b ctermfg=235 guibg=#ACE6FE ctermbg=80 gui=NONE cterm=NONE

" --------------------------------------------------------
" Error
hi Error guifg=#f44747 ctermfg=80 guibg=#23211b ctermbg=203 gui=NONE cterm=NONE
hi ErrorMsg guifg=#f44747 ctermfg=80 guibg=#23211b ctermbg=203 gui=NONE cterm=NONE
hi TSError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi CocErrorHighlight guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocErrorSign guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocErrorLine  guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


" --------------------------------------------------------
" LSP related
" For more highlight group info, plz search help
"
" :h diagnostic-highlights
" :h diagnostic-signs
"
" Sign
hi LspDiagnosticsSignError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsSignWarn guifg=#ff9f1c ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsSignInfo guifg=#ff9f1c ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsSignHint guifg=#BBBBBB ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" Virtual text
hi DiagnosticVirtualTextError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#ff9f1c ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#ff9f1c ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#BBBBBB ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" Floating text
hi DiagnosticFloatingError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticFloatingWarn guifg=#ff9f1c ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticFloatingInfo guifg=#616e88 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticFloatingHint guifg=#BBBBBB ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" Underline text
hi DiagnosticUnderlineError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=NONE
hi DiagnosticUnderlineWarn guifg=#ff9f1c ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=NONE
hi DiagnosticUnderlineInfo guifg=#616e88 ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=NONE
hi DiagnosticUnderlineHint guifg=#BBBBBB ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=NONE


" --------------------------------------------------------
" Search
hi IncSearch guifg=#23211b ctermfg=235 guibg=#ff9f1c ctermbg=172 gui=underline cterm=underline
hi Search guifg=#23211b ctermfg=235 guibg=#ff9f1c ctermbg=172 gui=NONE cterm=NONE


" --------------------------------------------------------
" The color when you run `:checkhealth`
hi healthSuccess guifg=#23211b ctermfg=80 guibg=#ACE6FE ctermbg=60 gui=NONE cterm=NONE
hi healthWarning guifg=#23211b ctermfg=172 guibg=#FF9F1C ctermbg=60 gui=NONE cterm=NONE
hi healthError guifg=#23211b ctermfg=203 guibg=#f44747 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Floating window
hi NormalFloat guifg=#ACE6FE ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi FloatBorder guifg=#ACE6FE ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE


" --------------------------------------------------------
" Popup menu (code complection, hover floating window, error window)
hi Pmenu guifg=#6fc3df ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi PmenuSbar guifg=#6fc3df ctermfg=80 guibg=#011627 ctermbg=60 gui=NONE cterm=NONE
hi PmenuSel guifg=#23211b ctermfg=195 guibg=#FF9F1C ctermbg=235 gui=NONE cterm=NONE
hi PmenuThumb guifg=#ACE6FE ctermfg=195 guibg=#9DB4C0 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" `nvim-cmp` complection menu
hi CmpItemAbbrDeprecated guifg=#6fc3df ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi CmpItemAbbrMatch guifg=#ACE6FE ctermfg=195 guibg=#011627 ctermbg=60 gui=NONE cterm=NONE
hi CmpItemAbbrMatchFuzzy guifg=#ACE6FE ctermfg=195 guibg=#011627 ctermbg=60 gui=NONE cterm=NONE
hi CmpItemKind guifg=#ffe64d ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi CmpItemMenu guifg=#ffe64d ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE


" --------------------------------------------------------
" String
hi String guifg=#ff9f1c ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStringRegex guifg=#ff9f1c ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSString guifg=#ff9f1c ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStringEscape guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


" --------------------------------------------------------
" Normal text and backgroud (all code non-keyword/function, popup window non-selected, etgc)
hi Normal guifg=#987a6d ctermfg=80 guibg=#372C2E ctermbg=235 gui=NONE cterm=NONE


" --------------------------------------------------------
" Spell checking
hi SpellBad guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellCap guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellLocal guifg=#6fc3df ctermfg=80 guibg=#23211b ctermbg=235 gui=underline cterm=underline
hi SpellRare guifg=#6fc3df ctermfg=80 guibg=#23211b ctermbg=235 gui=underline cterm=underline


" --------------------------------------------------------
" Status line
" hi StatusLine guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLine guibg=#00000000 gui=NONE cterm=NONE
hi StatusLineNC guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLineTerm guifg=#ACE6FE ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLineTermNC guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Message
hi ModeMsg guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi MoreMsg guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WarningMsg guifg=#23211b ctermfg=235 guibg=#FF9F1C ctermbg=172 gui=NONE cterm=NONE


" --------------------------------------------------------
" Tab
hi TabLine guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineFill guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineSel guifg=#ACE6FE ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Split
hi VertSplit guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=235 gui=NONE cterm=NONE



" --------------------------------------------------------
" Uncategory yet
hi MatchParen guifg=#ACE6FE ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi NonText guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Visual guifg=NONE ctermfg=NONE guibg=#494F54 ctermbg=60 gui=NONE cterm=NONE
hi VisualNOS guifg=NONE ctermfg=NONE guibg=#9EADB9 ctermbg=60 gui=NONE cterm=NONE
hi QuickFixLine guifg=#23211b ctermfg=235 guibg=#FF9F1C ctermbg=172 gui=NONE cterm=NONE
hi Terminal guifg=#6fc3df ctermfg=80 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi Folded guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi FoldColumn guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi SignColumn guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi Directory guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Question guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi WildMenu guifg=#ACE6FE ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi Title guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Boolean guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Character guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Comment guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi Conditional guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Constant guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Define guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Delimeter guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Exception guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Float guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Function guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Identifier guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Include guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Keyword guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Label guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Number guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Operator guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi PreProc guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Repeat guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Special guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialChar guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi Statement guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StorageClass guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Structure guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Tag guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Todo guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Type guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Typedef guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Macro guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi PreCondit guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiffAdd guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffChange guifg=#FF9F1C ctermfg=172 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffDelete guifg=#f44747 ctermfg=203 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffText guifg=#ffe64d ctermfg=221 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffAdded guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffChanged guifg=#FF9F1C ctermfg=172 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffRemoved guifg=#f44747 ctermfg=203 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffFileId guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=bold,reverse cterm=bold,reverse
hi diffFile guifg=#3b4048 ctermfg=238 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffNewFile guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffOldFile guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi gitconfigVariable guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi debugPc guifg=NONE ctermfg=NONE guibg=#6fc3df ctermbg=80 gui=NONE cterm=NONE
hi debugBreakpoint guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=reverse cterm=reverse

" --------------------------------------------------------
" Treesitter
hi TSPunctDelimiter guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSPunctBracket guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSPunctSpecial guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstant guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstBuiltin guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstMacro guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSCharacter guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSNumber guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSBoolean guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFloat guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSAnnotation guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSAttribute guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSNamespace guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFuncBuiltin guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFunction guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSFuncMacro guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSParameter guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSParameterReference guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSMethod guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSField guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSProperty guifg=#ACE6FE ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstructor guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConditional guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSRepeat guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSLabel guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSKeyword guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSKeywordFunction guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSKeywordOperator guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSOperator guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSException guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSType guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTypeBuiltin guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStructure guifg=#ff00ff ctermfg=201 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSInclude guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSVariable guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSVariableBuiltin guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSText guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStrong guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSEmphasis guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSUnderline guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTitle guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSLiteral guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi TSURI guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTag guifg=#ffe64d ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTagDelimiter guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSComment guifg=#8a817c ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic

" --------------------------------------------------------
" Html
hi htmlArg guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlBold guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi htmlEndTag guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH1 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH2 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH3 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH4 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH5 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH6 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlItalic guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi htmlLink guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi htmlSpecialChar guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlSpecialTagName guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTag guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTagN guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTagName guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTitle guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" --------------------------------------------------------
" Markdown
hi markdownBlockquote guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownBold guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownCode guifg=#BBBBBB ctermfg=80 guibg=NONE ctermbg=NONE gui=bold,italic cterm=bold,italic
hi markdownCodeBlock guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#FF9F1C ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH1 guifg=#ffe64d ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH2 guifg=#ffe64d ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH3 guifg=#ffe64d ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH4 guifg=#ffe64d ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH5 guifg=#ffe64d ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH6 guifg=#ffe64d ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownHeadingRule guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownId guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownIdDeclaration guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownIdDelimiter guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownItalic guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi markdownLinkDelimiter guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownLinkText guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownListMarker guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownOrdeerror11ListMarker guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownRule guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownUrl guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=underline cterm=underline

" --------------------------------------------------------
" Coc plugin
hi CocExplorerIndentLine guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferRoot guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileRoot guifg=#6fc3df ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferFullPath guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileFullPath guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferReadonly guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferModified guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferNameVisible guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileReadonly guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileModified guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileHidden guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerHelpLine guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocWarningHighlight guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocWarningSign guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocInfoSign guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocHintSign guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"CocWarningLine xxx cleared
"CocInfoLine    xxx cleared
"CocHintLine    xxx cleared
"CocSelectedLine xxx cleared

" --------------------------------------------------------
" Lsp diagnostic
" hi LSPDiagnosticsWarning guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi LspDiagnosticsInformation guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi LspDiagnosticsHint guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi LspDiagnosticsUnderlineWarning guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi LspDiagnosticsUnderlineInformation guifg=#ACE6FE ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi LspDiagnosticsUnderlineHint guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

"LspDiagnosticsDefaultHint xxx cleared
hi LspDiagnosticsVirtualTextHint guifg=#616e88 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsFloatingHint guifg=#616e88 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"
hi LspDiagnosticsVirtualTextError guifg=#f44747 ctermfg=Green guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticsVirtualTextError guifg=#f44747 ctermfg=Green guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsFloatingError guifg=#ff99c8 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

"LspDiagnosticsDefaultWarning xxx cleared
"LspDiagnosticsVirtualTextWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsFloatingWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsDefaultInformation xxx cleared
"LspDiagnosticsVirtualTextInformation xxx links to LspDiagnosticsDefaultInformation
"LspDiagnosticsFloatingInformation xxx links to LspDiagnosticsDefaultInformation


" --------------------------------------------------------
" Telescope
hi TelescopeSelection guifg=#23211b ctermfg=176 guibg=#ACE6FF ctermbg=NONE gui=NONE cterm=NONE
"TelescopeSelection xxx links to Visual
hi TelescopeSelectionCaret guifg=#23211b ctermfg=176 guibg=#FF9F1C ctermbg=NONE gui=NONE cterm=NONE
"TelescopeMultiSelection xxx links to Type
hi TelescopeNormal guifg=#ACE6FF ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TelescopePreviewNormal guifg=#ACE6FF ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TelescopeBorder guifg=#ACE6FF ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"TelescopePromptBorder xxx links to TelescopeBorder
"TelescopeResultsBorder xxx links to TelescopeBorder
"TelescopePreviewBorder xxx links to TelescopeBorder
"TelescopeMatching xxx links to Special
"TelescopePromptPrefix xxx links to Identifier
"TelescopePreviewLine xxx links to Visual
"TelescopePreviewMatch xxx links to Search
"TelescopePreviewPipe xxx links to Constant
"TelescopePreviewCharDev xxx links to Constant
"TelescopePreviewDirectory xxx links to Directory
"TelescopePreviewBlock xxx links to Constant
"TelescopePreviewLink xxx links to Special
"TelescopePreviewSocket xxx links to Statement
"TelescopePreviewRead xxx links to Constant
"TelescopePreviewWrite xxx links to Statement
"TelescopePreviewExecute xxx links to String
"TelescopePreviewHyphen xxx links to NonText
"TelescopePreviewSticky xxx links to Keyword
"TelescopePreviewSize xxx links to String
"TelescopePreviewUser xxx links to Constant
"TelescopePreviewGroup xxx links to Constant
"TelescopePreviewDate xxx links to Directory
"TelescopeResultsClass xxx links to Function
"TelescopeResultsConstant xxx links to Constant
"TelescopeResultsField xxx links to Function
"TelescopeResultsFunction xxx links to Function
"TelescopeResultsMethod xxx links to Method
"Method         xxx cleared
"TelescopeResultsOperator xxx links to Operator
"TelescopeResultsStruct xxx links to Struct
"Struct         xxx cleared
"TelescopeResultsVariable xxx links to SpecialChar
"TelescopeResultsLineNr xxx links to LineNr
"TelescopeResultsIdentifier xxx links to Identifier
"TelescopeResultsNumber xxx links to Number
"TelescopeResultsComment xxx links to Comment
"TelescopeResultsSpecialComment xxx links to SpecialComment
"TelescopeResultsDiffChange xxx links to DiffChange
"TelescopeResultsDiffAdd xxx links to DiffAdd
"TelescopeResultsDiffDelete xxx links to DiffDelete
"TelescopeResultsDiffUntracked xxx links to NonText

" --------------------------------------------------------
" galaxyline plugin
hi GalaxyViModeNomral guifg=#23211b guibg=#ACE6FF gui=bold
hi GalaxyViModeInsert guifg=#23211b guibg=#ffe64d gui=bold
hi GalaxyViModeCommand guifg=#23211b guibg=#ffe64d gui=bold
hi GalaxyViModeVisual guifg=#23211b guibg=#c678dd gui=bold
hi GalaxyViModeOther guifg=#FFFFFF guibg=#F44747 gui=bold

hi GalaxyFileName guifg=#ff9f1c guibg=NONE gui=bold

hi GalaxyShowGitBranch guifg=#6fc3df guibg=NONE gui=bold

hi GalaxySpellChecking guifg=#23211b guibg=#afd700 gui=bold

hi GalaxyDiagnosticError guifg=#f44747 guibg=NONE gui=bold
hi GalaxyDiagnosticWarn guifg=#ff9f1c guibg=NONE gui=bold
hi GalaxyDiagnosticHint guifg=#616e88 guibg=NONE gui=bold
hi GalaxyDiagnosticInfo guifg=#616e88 guibg=NONE gui=bold

hi GalaxyFileType guifg=#ff9f1c guibg=NONE gui=bold
hi GalaxyFileEncode guifg=#afd700 guibg=NONE gui=bold
hi GalaxyFileEncodeSeparator guibg=NONE

hi GalaxyLinePercent guifg=#6fc3df guibg=NONE gui=bold
hi GalaxyLinePercentSeparator guibg=NONE

hi GalaxyLineInfo guifg=#ACE6FF guibg=NONE gui=bold
hi GalazyLineInfoSeparator guibg=NONE

hi GalaxyLineColumn guifg=#6fc3df guibg=NONE
hi GalazyLineColumnSeparator guibg=NONE


" --------------------------------------------------------
" Typescript
hi typescriptTSInclude guifg=#FFE64D ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptTSType guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptTSTypeBuiltin guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptTSKeyword guifg=#DE9E48 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptTSString guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptTSNumber guifg=#FFE64D ctermfg=176 guibg=NONE ctermbg=NONE gui=bold cterm=NONE

hi typescriptTSVariable guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptTSVariableBuiltin guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptVariableDeclaration guifg=#FECA27 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptTSConstructor guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptTSFunction guifg=#FFA534 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptTSProperty guifg=#FFA534 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptTSMethod guifg=#FFA534 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptTSParameter guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptAsyncFuncKeyword guifg=#FF0000 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptTSPunctBracket guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptTSPunctDelimiter guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi typescriptTSComment guifg=#5F6367 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

"#FFDFB7 typescriptTSOperator
"typescriptArrowFuncDef
"typescriptTypeArguments
