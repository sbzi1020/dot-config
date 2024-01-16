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
let g:colors_name='cute_duck'

" Main yellow: #FFA534
" Light yellow: #FFDFB7
" Middium yellow: #FFB85F
" Another yellow: #FECA27
" yellow #FFE64D
" Font gray: #5F6367
" light green: #92BD46
" Error red: #FE0602
" Background: #282726
" Yello white: #FFFEFD

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
hi Cursor1 guifg=#282726 ctermfg=235 guibg=#ACE6FE ctermbg=80 gui=NONE cterm=NONE
hi Cursor2 guifg=#282726 ctermfg=235 guibg=#ACE6FE ctermbg=80 gui=NONE cterm=NONE

" --------------------------------------------------------
" Error
hi Error guifg=#f44747 ctermfg=80 guibg=#282726 ctermbg=203 gui=NONE cterm=NONE
hi ErrorMsg guifg=#f44747 ctermfg=80 guibg=#282726 ctermbg=203 gui=NONE cterm=NONE
hi TSError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=underline


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
hi IncSearch guifg=#282726 ctermfg=235 guibg=#ff9f1c ctermbg=172 gui=underline cterm=underline
hi Search guifg=#282726 ctermfg=235 guibg=#ff9f1c ctermbg=172 gui=NONE cterm=NONE


" --------------------------------------------------------
" The color when you run `:checkhealth`
hi healthSuccess guifg=#282726 ctermfg=80 guibg=#ACE6FE ctermbg=60 gui=NONE cterm=NONE
hi healthWarning guifg=#282726 ctermfg=172 guibg=#FF9F1C ctermbg=60 gui=NONE cterm=NONE
hi healthError guifg=#282726 ctermfg=203 guibg=#f44747 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Floating window
hi NormalFloat guifg=#ACE6FE ctermfg=60 guibg=#282726 ctermbg=235 gui=NONE cterm=NONE
hi FloatBorder guifg=#ACE6FE ctermfg=60 guibg=#282726 ctermbg=235 gui=NONE cterm=NONE


" --------------------------------------------------------
" Popup menu (code complection, hover floating window, error window)
hi Pmenu guifg=#6fc3df ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi PmenuSbar guifg=#6fc3df ctermfg=80 guibg=#011627 ctermbg=60 gui=NONE cterm=NONE
hi PmenuSel guifg=#282726 ctermfg=195 guibg=#FF9F1C ctermbg=235 gui=NONE cterm=NONE
hi PmenuThumb guifg=#ACE6FE ctermfg=195 guibg=#9DB4C0 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" `nvim-cmp` complection menu
hi CmpItemAbbrDeprecated guifg=#6fc3df ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi CmpItemAbbrMatch guifg=#ACE6FE ctermfg=195 guibg=#011627 ctermbg=60 gui=NONE cterm=NONE
hi CmpItemAbbrMatchFuzzy guifg=#ACE6FE ctermfg=195 guibg=#011627 ctermbg=60 gui=NONE cterm=NONE
hi CmpItemKind guifg=#ffe64d ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE
hi CmpItemMenu guifg=#ffe64d ctermfg=80 guibg=#011627 ctermbg=233 gui=NONE cterm=NONE


" --------------------------------------------------------
" Normal text (all code non-keyword/function, popup window non-selected, etgc)
hi Normal guifg=#FFDFB7 ctermfg=80 guibg=#282726 ctermbg=235 gui=NONE cterm=NONE


" --------------------------------------------------------
" Spell checking
hi SpellBad guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellCap guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellLocal guifg=#6fc3df ctermfg=80 guibg=#282726 ctermbg=235 gui=underline cterm=underline
hi SpellRare guifg=#6fc3df ctermfg=80 guibg=#282726 ctermbg=235 gui=underline cterm=underline


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
hi WarningMsg guifg=#282726 ctermfg=235 guibg=#FF9F1C ctermbg=172 gui=NONE cterm=NONE


" --------------------------------------------------------
" Tab
hi TabLine guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineFill guifg=#6fc3df ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineSel guifg=#ACE6FE ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Split
hi VertSplit guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=235 gui=NONE cterm=NONE



" --------------------------------------------------------
" Telescope
hi TelescopeSelection guifg=#282726 ctermfg=176 guibg=#ACE6FF ctermbg=NONE gui=NONE cterm=NONE
"TelescopeSelection xxx links to Visual
hi TelescopeSelectionCaret guifg=#282726 ctermfg=176 guibg=#FF9F1C ctermbg=NONE gui=NONE cterm=NONE
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
hi GalaxyViModeNomral guifg=#282726 guibg=#ACE6FF gui=bold
hi GalaxyViModeInsert guifg=#282726 guibg=#ffe64d gui=bold
hi GalaxyViModeCommand guifg=#282726 guibg=#ffe64d gui=bold
hi GalaxyViModeVisual guifg=#282726 guibg=#c678dd gui=bold
hi GalaxyViModeOther guifg=#FFFFFF guibg=#F44747 gui=bold

hi GalaxyFileName guifg=#ff9f1c guibg=NONE gui=bold

hi GalaxyShowGitBranch guifg=#6fc3df guibg=NONE gui=bold

hi GalaxySpellChecking guifg=#282726 guibg=#afd700 gui=bold

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

hi typescriptTSKeyword guifg=#FFE64D ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

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
