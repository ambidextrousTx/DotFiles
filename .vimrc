" Ambidextrous
" $MYVIMRC
" Evolving over time
" Influences - Armin Ronacher, Steve Losh, Harry Percival, Ben Orenstein, Drew
" Neil

" Tips
" nore = non recursive mappings are better because they never take other
" mappings into account and thus never get into recursive mode. 
" ALWAYS use non recursive mappings
" ---------------------------------------- 

" Greeting at startup
" Cute, but not needed
" echo ">^.^<"

" Adding tpope's Pathogen for easy plugin management {{{
execute pathogen#infect()
filetype plugin indent on 
" }}}

" Initialization stuff {{{
set nocompatible 	" No compatibility with legacy vi

" UTF-8 all the things
set encoding=utf-8

" Leader key
let mapleader = ","

" From Derek Wyatt's videos, for end of current word changing
set cpoptions+=$

" Set a vertical line at column 80 for visual aid for longer code lines
set colorcolumn=80

" Steve Losh/ Drew Neil: tab and eol characters, and mapping to toggl
" Colors work for badwolf and some other schemes (NonText and SpecialKey)
set list
set listchars=tab:▸\ ,eol:¬

nnoremap <leader>l :set list!<CR>

syntax on
if has("gui_running")
    colorscheme badwolf
    " GUI font, labels on tabs
    if has("mac")
        set guifont=Source\ Code\ Pro:h13
    else
        set guifont=Source\ Code\ Pro\ 13
    endif
    set guitablabel=%N\ %t
    " Setting spelling only when the GUI is running
    set spell
    " Autmatically change dirs upon opening
    " Only needed/ works for GUI
    set autochdir
else
    colorscheme default
endif

set t_Co=256

" Filetype detection and behavior adjustment
if has("autocmd")
    filetype on
    filetype plugin on
    " Added specially for Scala
    filetype indent on
    set autoindent
    set si
endif

" }}}

" Basics, one liners {{{
" Disabling paste - having paste set doesn't let abbreviations work
set nopaste

set showcmd " Show the number of selected lines, characters etc.
set hlsearch
set incsearch
" Does not work with list on
set linebreak " Don't break words on line warp

" Split to the bottom and right by default
set splitbelow
set splitright

" Allow backspacing in insert mode
set backspace=indent,eol,start

" Highlight the current line
set cursorline

" Show matching parentheses for a bit
set showmatch
set matchtime=1

" History and undo levels 
set history=1000
set undolevels=1000

" Don't autocomplete some file names (don't need to open them)
set wildignore=*.swp,*.bak,*.pyc,*.class

" Clearing out the results of a search
nnoremap <leader><space> :noh<CR>

" When opening a file, do not fold blocks
" Folding is managed by the filetypes (see augroups below)
set foldlevelstart=99

" Line numbers
set number          
" Number of columns for the line numbers
set numberwidth=4                               

set go-=T

set wildmode=longest,list " Shell-style autocomplete

" Remaps
" Don't need man page brought up
nnoremap K <nop> 

" Using spelling suggestions a bit easily
" Needs spell set
" Adds the dictionary to autocomplete so <C-N> and <C-P> will work without <C-X><C-K> first
set complete-=k complete+=k

" }}}

" Useful functions {{{
" Start relative number or normal number
nnoremap <leader>sr :call SetRelativeNumber()<CR>
nnoremap <leader>sn :call SetNumber()<CR>

" Functions to toggle between number and nonumber
function! SetNumber()
    set number!                                 
endfunction

function! SetRelativeNumber()
    set relativenumber!                         
endfunction

" My first own Vim function
nnoremap <leader>r :call Ambidextrous()<CR>
function! Ambidextrous()
    echo "This is Ravi's Vim setup"
endfunction

" Capitalize sentence and center it, then move down
nnoremap <leader>c :call CapitalizeCenterAndMoveDown()<CR>
function! CapitalizeCenterAndMoveDown()
    s/\<./\u&/g "Built-in substitution capitalizes every word
    center	"Built-in center command centers entire line
    +1	"Built-in relative motion (+1 line down)
endfunction
" }}} "

" Navigation {{{
" Moving lines up and down
nnoremap _ ddkP
nnoremap - ddp

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}

" Useful mappings {{{
" A shortcut to CtrlPMixed
nnoremap <leader>p :CtrlPMixed<CR>

" A shortcut to TagbarToggle from Tagbar
nnoremap <leader>t :TagbarToggle<CR>

" Make it easier to make it easier to edit text
" Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Since :w mostly becomes :W when done manually
nnoremap <leader>w :w<CR>

" Justifying a paragraph in a simpler way
nnoremap <leader>j gqip

" Toggle spell check
nnoremap <leader>s :set spell!<CR>

" Surrounding the word with single and double quotes
" Courtesy Steve Losh
nnoremap <leader>' viw<ESC>a'<ESC>hbi'<ESC>lel
nnoremap <leader>" viw<ESC>a"<ESC>hbi"<ESC>lel

" 'Make space above and below'
nnoremap <leader>m O<ESC>jo<ESC>k

" Toggle background light or dark
nnoremap <leader>bl :set background=light<CR>
nnoremap <leader>bd :set background=dark<CR>

nnoremap <Space> <PageDown>
nnoremap <Tab> <PageUp>
" Insert current date
inoremap <silent> <C-D>d <C-R>=strftime("%e %b %Y")<CR>
" Insert current time
inoremap <silent> <C-D>t <C-R>=strftime("%l:%M %p")<CR>
" }}}

" Mappings for running things {{{ 
" Running things in Python
nnoremap <leader>pn :sp ./project-notes.txt<CR>
nnoremap <leader>rp :!python %<CR>
nnoremap <leader>rt :!pyrg %<CR>


" Running things in Ruby
nnoremap <leader>rr :!ruby %<CR>

" Running things in JavaScript
nnoremap <leader>rn :!node %<CR>

" Running an SML program
nnoremap <leader>rm :!sml %<CR>

" Running a Scala script
nnoremap <leader>rs :!scala %<CR>

" }}}

" Commenting and uncommenting {{{
" Commenting - preferable for blocks
vnoremap <leader># :norm I# <CR>
vnoremap <leader>/ :norm I// <CR>

" Better commenting
autocmd filetype python nnoremap <buffer> <leader>c I# <ESC>
autocmd filetype ruby nnoremap <buffer> <leader>c I# <ESC>
autocmd filetype java nnoremap <buffer> <leader>c I// <ESC>
autocmd filetype scala nnoremap <buffer> <leader>c I// <ESC>
autocmd filetype javascript nnoremap <buffer> <leader>c I// <ESC>
autocmd filetype c nnoremap <buffer> <leader>c I// <ESC>
autocmd filetype cpp nnoremap <buffer> <leader>c I// <ESC>
autocmd filetype cs nnoremap <buffer> <leader>c I// <ESC>
autocmd filetype tex nnoremap <buffer> <leader>c I% <ESC>
autocmd filetype sml nnoremap <buffer> <leader>c I(*<SPACE><SPACE><ESC>xA<SPACE>*)<ESC>0
" Add more filetypes as needed  

" Uncommenting - preferable for blocks
vnoremap <leader>n# :norm ^2x<CR>
vnoremap <leader>n/ :norm ^3x<CR>

" Better uncommenting 
autocmd filetype python nnoremap <buffer> <leader>u ^2x
autocmd filetype ruby nnoremap <buffer> <leader>u ^2x
autocmd filetype java nnoremap <buffer> <leader>u ^3x
autocmd filetype scala nnoremap <buffer> <leader>u ^3x
autocmd filetype javascript nnoremap <buffer> <leader>u ^3x
autocmd filetype c nnoremap <buffer> <leader>u ^3x
autocmd filetype cpp nnoremap <buffer> <leader>u ^3x
autocmd filetype cs nnoremap <buffer> <leader>u ^3x
autocmd filetype tex nnoremap <buffer> <leader>u ^2x
autocmd filetype sml nnoremap <buffer> <leader>u ^3xA<BS><BS><BS><ESC>0
" }}}

" Indenting {{{
" Indent the file from top to bottom and leave the cursor at that point
nnoremap <leader>i :norm gg=G<CR>`.
" Round the indent to a multiple of shiftwidth
set shiftround                                  

set autoindent
set copyindent

" }}}

" Common abbreviations {{{
" Note: must disable paste (set nopaste) for abbreviations to work
iabbrev teh the
iabbrev @@ RaviSinha@my.unt.edu
iabbrev and and
iabbrev thign thing
iabbrev thigns things
iabbrev waht what
iabbrev tehn then
" Add more as and when needed
" }}}

" Autocmds {{{
" Sourcing your $MYVIMRC makes Vim read your autocmds again, 
" and it has no way of knowing whether it's a duplicate. 
" That makes Vim run slower because it 
" executes the same commands over and over; grouping prevents that
" Event, Pattern, Command

augroup filetype_html
    " Clean out existing commands in the group
    autocmd!
    "Do not wrap HTML documents (local buffer only)
    autocmd BufNewFile,BufRead *.html setlocal nowrap 
    " Automatically indent HTML before saving
    " Don't like intendation overhead (time) at every save
    " autocmd BufWritePre *.html normal gg=G 
augroup END

augroup filetype_python
    autocmd!
    "PEP-8, set 80 character limit on lines
    autocmd FileType python set textwidth=79 
    autocmd FileType python setlocal foldmethod=indent
    " No tabs in the source file
    " All tabs are 4 space characters
    set tabstop=4 
    set shiftwidth=4
    set softtabstop=4
    " Use spaces, not tabs
    set expandtab 
augroup END

" Code folding for VimScript files
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Special stuff for Java files
augroup filetype_java
    autocmd!
    autocmd FileType vim setlocal foldmethod=syntax
augroup END

" Special tab-spacing for Ruby files
augroup filetype_ruby
    autocmd!
    autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" }}}

" {{{ Status bar
" Part from the official Vim page
" Part from Steve Losh's book
" Beautify the status bar
set laststatus=2
set statusline=
set statusline+=%1*%40F\ 
set statusline+=%3*\ %{&fenc!=''?&fenc:&enc}\ 
set statusline+=%1*\ %Y\ 
set statusline+=%4*\ %05l/%05L:%03c\ 
set statusline+=%1*\ %-16{strftime(\"%Y-%m-%d\ %H:%M\")}\ 
set statusline+=%5*\ %-3m\ 
" }}}

" --- not working yet / still creating ---

" Creating Terminal-like mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Highlighting different words using different colors
" Leader with 1-6
" Courtesy Steve Losh
" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <leader>0 :call HiInterestingWord(0)<cr>
nnoremap <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord0 guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" Via Drew Neil at Vimcasts.org
" Ctrl Shift P to see the highlight group for word
" Help in creating Vim colorscheme files
" Show syntax highlighting groups for word under cursor
nnoremap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"Set ctags to the newer version installed from SourceForge
"The newer version is exuberant ctags
"Needed to work with Taglist
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
map <F4> :TlistToggle<CR>
"Build tags for the current working directory
map <F5> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"For Michael Sanders' TextMate Snippet Emulator plugin

" Functions
function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction

nnoremap <silent> ;s :call ToggleSyntax()<CR>

" Vim Scripts from the official Vim page

hi User1 guifg=#112605  guibg=#aefe7B gui=italic
hi User2 guifg=#391100  guibg=#d3905c gui=italic
hi User3 guifg=#292b00  guibg=#f4f597 gui=italic
hi User4 guifg=#051d00  guibg=#7dcc7d gui=italic
hi User5 guifg=#002600  guibg=#67ab6e gui=italic

" Automatically and intelligently complete brackets, quotes etc
" You can modify this dictionary as you wish.
let s:match = {'(': ')',
            \'{': '}',
            \'[': ']',
            \'¡': '!',
            \'¿': '?'}
" This list is for pairs in which the closing symbol is the same as the
" opening one.
let s:smatch = ["'", "\""]

let s:alpha = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
            \"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
            \"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
            \"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
for [s:o, s:c] in items(s:match)
    execute 'ino <silent> ' . s:o . " <C-R>=VracketOpen('" . s:o . "')<CR>"
    execute 'ino <silent> ' . s:c . " <C-R>=VracketClose('" . s:o . "')<CR>"
endfor
for s:b in s:smatch
    execute 'ino <silent> ' . s:b . ' <C-R>=VracketBoth("\' . s:b . '")<CR>'
endfor
inoremap <silent> <BS> <C-R>=VracketBackspace()<CR>

function! VracketOpen(bracket)
    let l:o = a:bracket
    let l:c = s:match[l:o]

    return l:o . l:c . "\<Left>"
endfunction

function! VracketClose(bracket)
    let l:c = s:match[a:bracket]

    if s:GetCharAt(0) == l:c
        return "\<Right>"
    endif
    return l:c
endfunction

function! VracketBoth(bracket)
    if s:GetCharAt(0) == a:bracket
        return "\<Right>"
    endif
    if col('.') == 1
        return a:bracket . a:bracket . "\<Left>"
    endif
    if s:GetCharAt(-1) == a:bracket || count(s:alpha, s:GetCharAt(-1)) == 1
        return a:bracket
    endif
    return a:bracket . a:bracket . "\<Left>"
endfunction

function! VracketBackspace()
    if col('.') == 1
        return "\<BS>"
    endif

    if get(s:match, s:GetCharAt(-1), '  ') == s:GetCharAt(0)
        return "\<Esc>\"_2s"
    endif

    if count(s:smatch, s:GetCharAt(0)) == 1 && s:GetCharAt(-1) == s:GetCharAt(0)
        return "\<Esc>\"_2s"
    endif
    return "\<BS>"
endfunction

function! s:GetCharAt(pos)
    let l:line = split(getline('.'), '\zs')
    let l:pos = s:Column() + a:pos
    if l:pos < 0 || l:pos >= len(l:line)
        return ''
    else
        return l:line[l:pos]
    endif
endfunction

function! s:Column()
    return col('.') > 1 ? strchars(getline(line('.'))[:col('.') - 2]) : 0
endfunction
