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
let g:colors_name='classic_old_green'

" --------------------------------------------------------
"
" `hi/highlight` accepts the settings below:
"
" * {group_name} - The color settings will be applied to, `:h highlight-group`
" * guifg={foreground_color} - `None` means transparent colors
" * guibg={background_color} - `None` means transparent colors
" * gui={font_style_separated_with_comma} - `underline,bold,italic,NONE`
"
" --------------------------------------------------------


" --------------------------------------------------------
" Color column vertical bar
hi ColorColumn guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Relative number bar
hi LineNr guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CursorLineNr guifg=#ffee93 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


" --------------------------------------------------------
" Error
hi Error guifg=#f44747 ctermfg=80 guibg=#23211b ctermbg=203 gui=NONE cterm=NONE
hi ErrorMsg guifg=#f44747 ctermfg=80 guibg=#23211b ctermbg=203 gui=NONE cterm=NONE
hi TSError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi CocErrorHighlight guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocErrorSign guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsDefaultError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsUnderlineError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


" --------------------------------------------------------
" Search
hi IncSearch guifg=#23211b ctermfg=235 guibg=#C678DD ctermbg=172 gui=underline cterm=underline
hi Search guifg=#23211b ctermfg=235 guibg=#C678DD ctermbg=172 gui=NONE cterm=NONE


" --------------------------------------------------------
" The color when you run `:checkhealth`
hi healthSuccess guifg=#23211b ctermfg=80 guibg=#ffc09f ctermbg=60 gui=NONE cterm=NONE
hi healthWarning guifg=#23211b ctermfg=172 guibg=#FF9F1C ctermbg=60 gui=NONE cterm=NONE
hi healthError guifg=#23211b ctermfg=203 guibg=#f44747 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" Popup menu (code complection, hover floating window, error window)
hi Pmenu guifg=#adf7b6 ctermfg=80 guibg=#3d405b ctermbg=233 gui=NONE cterm=NONE
hi PmenuSbar guifg=#adf7b6 ctermfg=80 guibg=#3d405b ctermbg=60 gui=NONE cterm=NONE
hi PmenuSel guifg=#23211b ctermfg=195 guibg=#ffc09f ctermbg=235 gui=NONE cterm=NONE
hi PmenuThumb guifg=#ffc09f ctermfg=195 guibg=#9DB4C0 ctermbg=60 gui=NONE cterm=NONE


" --------------------------------------------------------
" String
hi String guifg=#C678DD ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStringRegex guifg=#C678DD ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSString guifg=#C678DD ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStringEscape guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


" --------------------------------------------------------
" Normal text (all code non-keyword/function, popup window non-selected, etgc)
hi Normal guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=235 gui=NONE cterm=NONE


" --------------------------------------------------------
" Spell checking
hi SpellBad guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellCap guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=235 gui=underline,bold cterm=underline,bold
hi SpellLocal guifg=#adf7b6 ctermfg=80 guibg=#23211b ctermbg=235 gui=underline cterm=underline
hi SpellRare guifg=#adf7b6 ctermfg=80 guibg=#23211b ctermbg=235 gui=underline cterm=underline


hi Cursor guifg=#23211b ctermfg=235 guibg=#adf7b6 ctermbg=80 gui=NONE cterm=NONE
hi CursorLine guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi MatchParen guifg=#ffc09f ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi NonText guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Visual guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi VisualNOS guifg=NONE ctermfg=NONE guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi QuickFixLine guifg=#23211b ctermfg=235 guibg=#FF9F1C ctermbg=172 gui=NONE cterm=NONE
hi Terminal guifg=#adf7b6 ctermfg=80 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi Folded guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi FoldColumn guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi SignColumn guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi Directory guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi ModeMsg guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi MoreMsg guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Question guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StatusLine guifg=#adf7b6 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLineNC guifg=#adf7b6 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLineTerm guifg=#ffc09f ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi StatusLineTermNC guifg=#adf7b6 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi WarningMsg guifg=#23211b ctermfg=235 guibg=#FF9F1C ctermbg=172 gui=NONE cterm=NONE
hi WildMenu guifg=#ffc09f ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLine guifg=#adf7b6 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineFill guifg=#adf7b6 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi TabLineSel guifg=#ffc09f ctermfg=195 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi Title guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VertSplit guifg=#616e88 ctermfg=60 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi Boolean guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Character guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Comment guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi Conditional guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Constant guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Define guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Delimeter guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Exception guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Float guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Function guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Identifier guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Include guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Keyword guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Label guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Number guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Operator guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi PreProc guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Repeat guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Special guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialChar guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi Statement guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StorageClass guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Structure guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Tag guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Todo guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Type guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Typedef guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi Macro guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi PreCondit guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiffAdd guifg=#adf7b6 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffChange guifg=#FF9F1C ctermfg=172 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffDelete guifg=#f44747 ctermfg=203 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi DiffText guifg=#ffee93 ctermfg=221 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffAdded guifg=#adf7b6 ctermfg=80 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffChanged guifg=#FF9F1C ctermfg=172 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffRemoved guifg=#f44747 ctermfg=203 guibg=#616e88 ctermbg=60 gui=NONE cterm=NONE
hi diffFileId guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=bold,reverse cterm=bold,reverse
hi diffFile guifg=#3b4048 ctermfg=238 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffNewFile guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffOldFile guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi gitconfigVariable guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi debugPc guifg=NONE ctermfg=NONE guibg=#adf7b6 ctermbg=80 gui=NONE cterm=NONE
hi debugBreakpoint guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=reverse cterm=reverse
hi TSPunctDelimiter guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSPunctBracket guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSPunctSpecial guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstant guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstBuiltin guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstMacro guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSCharacter guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSNumber guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSBoolean guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFloat guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSAnnotation guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSAttribute guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSNamespace guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFuncBuiltin guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFunction guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSFuncMacro guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSParameter guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSParameterReference guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSMethod guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSField guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSProperty guifg=#ffc09f ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConstructor guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSConditional guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSRepeat guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSLabel guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSKeyword guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSKeywordFunction guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSKeywordOperator guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSOperator guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi TSException guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSType guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTypeBuiltin guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStructure guifg=#ff00ff ctermfg=201 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSInclude guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSVariable guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSVariableBuiltin guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSText guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSStrong guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSEmphasis guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSUnderline guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTitle guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSLiteral guifg=#616e88 ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi TSURI guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTag guifg=#ffee93 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSTagDelimiter guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSComment guifg=#8a817c ctermfg=60 guibg=NONE ctermbg=NONE gui=italic cterm=italic

hi htmlArg guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlBold guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi htmlEndTag guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH1 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH2 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH3 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH4 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH5 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlH6 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlItalic guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi htmlLink guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi htmlSpecialChar guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlSpecialTagName guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTag guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTagN guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTagName guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi htmlTitle guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" --------------------------------------------------------
" Markdown
hi markdownBlockquote guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownBold guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi markdownCode guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownCodeBlock guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH1 guifg=#ffee93 ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH2 guifg=#ffee93 ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH3 guifg=#ffee93 ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH4 guifg=#ffee93 ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH5 guifg=#ffee93 ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownH6 guifg=#ffee93 ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownHeadingRule guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownId guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownIdDeclaration guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownIdDelimiter guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownItalic guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=italic cterm=italic
hi markdownLinkDelimiter guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownLinkText guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownListMarker guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownOrdeerror11ListMarker guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownRule guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownUrl guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi CocExplorerIndentLine guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferRoot guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileRoot guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
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
hi CocInfoSign guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocHintSign guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi EasyMotionTarget guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi EasyMotionTarget2First guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi EasyMotionTarget2Second guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi EasyMotionShade guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SignifySignAdd guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SignifySignChange guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SignifySignChangeDelete guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SignifySignDelete guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Sneak guifg=#23211b ctermfg=235 guibg=#FF9F1C ctermbg=172 gui=underline cterm=underline
hi SneakScope guifg=#adf7b6 ctermfg=80 guibg=#23211b ctermbg=235 gui=NONE cterm=NONE
hi SneakLabel guifg=#23211b ctermfg=235 guibg=#FF9F1C ctermbg=172 gui=underline cterm=underline
hi SneakLabelMask guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyNumber guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySelect guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyBracket guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySpecial guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyVar guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyPath guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyFile guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySlash guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyHeader guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySection guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyFooter guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WhichKey guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WhichKeySeperator guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WhichKeyGroup guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi GitGutterAdd guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi GitGutterChange guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi GitGutterChangeDelete guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi GitGutterDelete guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LSPDiagnosticsWarning guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsInformation guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsHint guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsUnderlineWarning guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsUnderlineInformation guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsUnderlineHint guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VimwikiHeader1 guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi VimwikiHeader2 guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi VimwikiHeader3 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi VimwikiHeader4 guifg=#adf7b6 ctermfg=80 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi VimwikiHeader5 guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi VimwikiHeader6 guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi VimwikiLink guifg=#ffc09f ctermfg=195 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VimwikiHeaderChar guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VimwikiHR guifg=#FF9F1C ctermfg=172 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VimwikiList guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VimwikiTag guifg=#c678dd ctermfg=176 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VimwikiMarkers guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
