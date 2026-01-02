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
let g:colors_name='pinkgirl'

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
hi ColorColumn guifg=NONE ctermfg=NONE guibg=#2e2e2e ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Relative number bar
hi LineNr guifg=#8a817c ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CursorLineNr guifg=#ef476f ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


" --------------------------------------------------------
" Error
hi Error guifg=#FFE64D ctermfg=80 guibg=#23211b ctermbg=203 gui=NONE cterm=NONE
hi ErrorMsg guifg=#FFE64D ctermfg=80 guibg=#23211b ctermbg=203 gui=NONE cterm=NONE
hi TSError guifg=#FFE64D ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi CocErrorHighlight guifg=#FFE64D ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocErrorSign guifg=#FFE64D ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocErrorLine  guifg=#FFE64D ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


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
hi IncSearch guifg=#23211b ctermfg=235 guibg=#d9ed92 ctermbg=172 gui=underline cterm=underline
hi Search guifg=#23211b ctermfg=235 guibg=#d9ed92 ctermbg=172 gui=NONE cterm=NONE


" --------------------------------------------------------
" The color when you run `:checkhealth`
hi healthSuccess guifg=#23211b ctermfg=80 guibg=#ff99c8 ctermbg=60 gui=NONE cterm=NONE
hi healthWarning guifg=#23211b ctermfg=172 guibg=#df740c ctermbg=60 gui=NONE cterm=NONE
hi healthError guifg=#23211b ctermfg=203 guibg=#f44747 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Popup menu (code complection, hover floating window)
hi Pmenu guifg=#d9ed92 ctermfg=80 guibg=#605770 ctermbg=233 gui=NONE cterm=NONE
hi PmenuSbar guifg=#d9ed92 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi PmenuSel guifg=#23211b ctermfg=195 guibg=#c678DD ctermbg=235 gui=bold cterm=bold
hi PmenuThumb guifg=#ff99c8 ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" String
hi String guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStringRegex guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSString guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStringEscape guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


" --------------------------------------------------------
" Normal text (all code non-keyword/function, popup window non-selected, etgc)
hi Normal guifg=#fcf6bd ctermfg=80 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE


" --------------------------------------------------------
" Spell checking
hi SpellBad guifg=#f44747 ctermfg=203 guibg=#23211b ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellCap guifg=#f44747 ctermfg=203 guibg=#23211b ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellLocal guifg=#fcf6bd ctermfg=80 guibg=#23211b ctermbg=235 gui=underline cterm=underline
hi SpellRare guifg=#fcf6bd ctermfg=80 guibg=#23211b ctermbg=235 gui=underline cterm=underline


" --------------------------------------------------------
" Status line
" hi StatusLine guifg=#fcf6bd ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLine guibg=#00000000
hi StatusLineNC guifg=#fcf6bd ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLineTerm guifg=#ff99c8 ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLineTermNC guifg=#fcf6bd ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Message
hi ModeMsg guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi MoreMsg guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WarningMsg guifg=#23211b ctermfg=235 guibg=#df740c ctermbg=172 gui=NONE cterm=NONE

" --------------------------------------------------------
" Tab
hi TabLine guifg=#fcf6bd ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineFill guifg=#fcf6bd ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineSel guifg=#ff99c8 ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Split
hi VertSplit guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE


" --------------------------------------------------------
" Uncategory yet
hi Cursor guifg=#23211b ctermfg=235 guibg=#fcf6bd ctermbg=80 gui=NONE cterm=NONE
hi CursorLine guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi MatchParen guifg=#ff99c8 ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi NonText guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Visual guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi VisualNOS guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi QuickFixLine guifg=#23211b ctermfg=235 guibg=#df740c ctermbg=172 gui=NONE cterm=NONE
hi Terminal guifg=#fcf6bd ctermfg=80 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi Folded guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi FoldColumn guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi SignColumn guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi Directory guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Question guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WildMenu guifg=#ff99c8 ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi Title guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Boolean guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Character guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Comment guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi Conditional guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Constant guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Define guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Delimeter guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Exception guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Float guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Function guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Identifier guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Include guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Keyword guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Label guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Number guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Operator guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi PreProc guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Repeat guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Special guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialChar guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi Statement guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StorageClass guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Structure guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Tag guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Todo guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Type guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Typedef guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Macro guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi PreCondit guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiffAdd guifg=#fcf6bd ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffChange guifg=#df740c ctermfg=172 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffDelete guifg=#f44747 ctermfg=203 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffText guifg=#ef476f ctermfg=221 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffAdded guifg=#fcf6bd ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffChanged guifg=#df740c ctermfg=172 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffRemoved guifg=#f44747 ctermfg=203 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffFileId guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=bold,reverse cterm=bold,reverse
hi diffFile guifg=#3b4048 ctermfg=238 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffNewFile guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffOldFile guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi gitconfigVariable guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi debugPc guifg=NONE ctermfg=NONE guibg=#fcf6bd ctermbg=80 gui=NONE cterm=NONE
hi debugBreakpoint guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=reverse cterm=reverse


" --------------------------------------------------------
" Treesitter
hi TSPunctDelimiter guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSPunctBracket guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSPunctSpecial guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstant guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstBuiltin guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstMacro guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSCharacter guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSNumber guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSBoolean guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFloat guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSAnnotation guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSAttribute guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSNamespace guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFuncBuiltin guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFunction guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSFuncMacro guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSParameter guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSParameterReference guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSMethod guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSField guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSProperty guifg=#ff99c8 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstructor guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConditional guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSRepeat guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSLabel guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSKeyword guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSKeywordFunction guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSKeywordOperator guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSOperator guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSException guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSType guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTypeBuiltin guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStructure guifg=#ff00ff ctermfg=201 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSInclude guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSVariable guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSVariableBuiltin guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSText guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStrong guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSEmphasis guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSUnderline guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTitle guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSLiteral guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi TSURI guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTag guifg=#ef476f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTagDelimiter guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSComment guifg=#8a817c ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic

" --------------------------------------------------------
" Html
hi htmlArg guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlBold guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi htmlEndTag guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH1 guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH2 guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH3 guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH4 guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH5 guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH6 guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlItalic guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi htmlLink guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi htmlSpecialChar guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlSpecialTagName guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTag guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTagN guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTagName guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTitle guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" --------------------------------------------------------
" Markdown
hi markdownBlockquote guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownBold guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownCode guifg=#ff99c8 ctermfg=80 guibg=NONE ctermbg=NONE gui=bold,italic cterm=bold,italic
hi markdownCodeBlock guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH1 guifg=#ef476f ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownH2 guifg=#ef476f ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownH3 guifg=#ef476f ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownH4 guifg=#ef476f ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownH5 guifg=#ef476f ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownH6 guifg=#ef476f ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownHeadingDelimiter guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownHeadingRule guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownId guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownIdDeclaration guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownIdDelimiter guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownItalic guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi markdownLinkDelimiter guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownLinkText guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownListMarker guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownOrdeerror11ListMarker guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownRule guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownUrl guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=underline cterm=underline

" --------------------------------------------------------
" Coc plugin
hi CocExplorerIndentLine guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferRoot guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileRoot guifg=#fcf6bd ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferFullPath guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileFullPath guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferReadonly guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferModified guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferNameVisible guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileReadonly guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileModified guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileHidden guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerHelpLine guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocWarningHighlight guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocWarningSign guifg=#df740c ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocInfoSign guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocHintSign guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"CocWarningLine xxx cleared
"CocInfoLine    xxx cleared
"CocHintLine    xxx cleared
"CocSelectedLine xxx cleared


" --------------------------------------------------------
" Lsp diagnostic
hi LSPDiagnosticsWarning guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsInformation guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsHint guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsUnderlineWarning guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsUnderlineInformation guifg=#ff99c8 ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsUnderlineHint guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"LspDiagnosticsDefaultHint xxx cleared
"LspDiagnosticsVirtualTextHint xxx links to LspDiagnosticsDefaultHint
"LspDiagnosticsFloatingHint xxx links to LspDiagnosticsDefaultHint
"LspDiagnosticsVirtualTextError xxx links to LspDiagnosticsDefaultError
"LspDiagnosticsFloatingError xxx links to LspDiagnosticsDefaultError
"LspDiagnosticsDefaultWarning xxx cleared
"LspDiagnosticsVirtualTextWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsFloatingWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsSignWarning xxx links to LspDiagnosticsDefaultWarning
"LspDiagnosticsDefaultInformation xxx cleared
"LspDiagnosticsVirtualTextInformation xxx links to LspDiagnosticsDefaultInformation
"LspDiagnosticsFloatingInformation xxx links to LspDiagnosticsDefaultInformation
"LspDiagnosticsSignInformation xxx links to LspDiagnosticsDefaultInformation


" --------------------------------------------------------
" Telescope
hi TelescopeSelection guifg=#23211b ctermfg=176 guibg=#FFE64D ctermbg=NONE gui=bold cterm=NONE
"TelescopeSelection xxx links to Visual
hi TelescopeSelectionCaret guifg=#23211b ctermfg=176 guibg=#ef476f ctermbg=NONE gui=bold cterm=NONE
"TelescopeMultiSelection xxx links to Type
hi TelescopeNormal guifg=#fcf6bd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TelescopePreviewNormal guifg=#fcf6bd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TelescopeBorder guifg=#fcf6bd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
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
hi GalaxyViModeNomral guifg=#23211b guibg=#fcf6bd gui=bold
hi GalaxyViModeInsert guifg=#23211b guibg=#FFE64D gui=bold
hi GalaxyViModeCommand guifg=#23211b guibg=#FFE64D gui=bold
hi GalaxyViModeVisual guifg=#23211b guibg=#c678dd gui=bold
hi GalaxyViModeOther guifg=#FFFFFF guibg=#F44747 gui=bold

hi GalaxyFileName guifg=#FFE64D guibg=NONE gui=bold

hi GalaxyShowGitBranch guifg=#6fc3df guibg=NONE gui=bold

hi GalaxySpellChecking guifg=#23211b guibg=#afd700 gui=bold

hi GalaxyDiagnosticError guifg=#f44747 guibg=NONE gui=bold
hi GalaxyDiagnosticWarn guifg=#ff9f1c guibg=NONE gui=bold
hi GalaxyDiagnosticHint guifg=#616e88 guibg=NONE gui=bold
hi GalaxyDiagnosticInfo guifg=#616e88 guibg=NONE gui=bold

hi GalaxyFileType guifg=#FFE64D guibg=NONE gui=bold
hi GalaxyFileEncode guifg=#FCF6BD guibg=NONE gui=bold
hi GalaxyFileEncodeSeparator guibg=NONE

hi GalaxyLinePercent guifg=#FCF6DB guibg=NONE gui=bold
hi GalaxyLinePercentSeparator guibg=NONE

hi GalaxyLineInfo guifg=#FCF6DB guibg=NONE gui=bold
hi GalazyLineInfoSeparator guibg=NONE

hi GalaxyLineColumn guifg=#FCF6DB guibg=NONE
hi GalazyLineColumnSeparator guibg=NONE


" --------------------------------------------------------
" Typescript

hi tsxTSTagDelimiter guifg=#fcf6bd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSInclude guifg=#FFE64D ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptTSType guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSTypeBuiltin guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptTSKeyword guifg=#FFE64D ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptTSString guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSNumber guifg=#FFE64D ctermfg=176 guibg=NONE ctermbg=NONE gui=bold cterm=NONE

" hi typescriptTSVariable guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSVariableBuiltin guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptVariableDeclaration guifg=#FECA27 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptTSConstructor guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptTSFunction guifg=#FFA534 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSProperty guifg=#FFA534 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSMethod guifg=#FFA534 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSParameter guifg=#FFDFB7 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptAsyncFuncKeyword guifg=#FF0000 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptTSPunctBracket guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi typescriptTSPunctDelimiter guifg=#92BD46 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" hi typescriptTSComment guifg=#5F6367 ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

"#FFDFB7 typescriptTSOperator
"typescriptArrowFuncDef
"typescriptTypeArguments
