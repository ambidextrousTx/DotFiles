" Introduction {{{
" Ambidextrous
" $MYVIMRC
" Evolving over time
" Influences - Armin Ronacher, Steve Losh, Harry Percival, Ben Orenstein,
" Drew Neil, Jack Franklin, Damian Conway

" Tips
" nore = non recursive mappings are better because they never take other
" mappings into account and thus never get into recursive mode.
" ALWAYS use non recursive mappings
" ----------------------------------------

" Greeting at startup
" Cute, but not needed
" echo ">^.^<"
" }}}
" Adding tpope's Pathogen for easy plugin management {{{
execute pathogen#infect()
" Supposed to automatically update Vim's helptags
execute pathogen#helptags()
filetype plugin indent on 
" }}}
" Initialization stuff {{{
set nocompatible	" No compatibility with legacy vi

" UTF-8 all the things
set encoding=utf-8

" Line-endings depend on the current system
" Ambidextrous- altered from the previous (unix,mac,dos)
" set fileformats=unix,mac,dos
if has("mac")
    set fileformat=mac
else 
    if has("unix")
        set fileformat=unix
    else
        set fileformat=dos
    endif
endif


" Leader key
let mapleader = ","

" From Derek Wyatt's videos, for end of current word changing
set cpoptions+=$

" Set a vertical line at column 80 for visual aid for longer code lines
" Turn off by default; can be toggled with shortcuts C0 and C1 
" Other tools like syntastic will highlight when a line is >= 80 cols
" set colorcolumn=80

" Steve Losh/ Drew Neil: tab and eol characters, and mapping to toggl
" Colors work for badwolf and some other schemes (NonText and SpecialKey)
" Does not work when word wrap is set and vice versa
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

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
    
    " In MacVim, disable some menu options that are unpleasing to the eye
    set go-=T
else
    colorscheme default
endif

" 256-colors
set t_Co=256

" Filetype detection and behavior adjustment
if has("autocmd")
    filetype off
    filetype plugin indent off
    set runtimepath+=/usr/local/go/misc/vim
    filetype plugin on
    filetype indent on
    filetype on
endif

" }}}
" Basics, one liners {{{
" 
" Interesting feature; keeping some context offset around when scrolling
set scrolloff=5
"
" Never need 'Ex mode'
nnoremap Q <NOP>
"
" Disabling paste - abbreviations do not work otherwise
set nopaste

set showcmd " Show the number of selected lines, characters etc.
set hlsearch
set incsearch
" Does not work with list on (for displaying the special characters)
set linebreak " Don't break words on line warp
" Like the idea of linebreaks showing explicitly
set showbreak=>\ 

" Split to the bottom and right by default
set splitbelow
set splitright

" Allow backspacing in insert mode
set backspace=indent,eol,start

" Autosave on losing focus (always save) - Steve Losh
au FocusLost * :wa

" Keep search matches in the middle of the window - Steve Losh
nnoremap n nzzzv
nnoremap N Nzzzv

" Am I ever going to use Vim's traditional regexes?
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Highlight the current line
set cursorline

" Show matching parentheses for a bit
set showmatch
set matchtime=1

" History and undo levels 
" Bumping up to 9,999; this isn't 1990s anymore, can use extra memory
set history=9999
set undolevels=9999

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

set wildmenu
set wildmode=longest,list " Shell-style autocomplete

" Don't need man page brought up
nnoremap K <nop> 

" Using spelling suggestions a bit easily
" Needs spell set
" Adds the dictionary to autocomplete so <C-N> and <C-P> will work without <C-X><C-K> first
set complete-=k complete+=k

" When joining lines with J, do not add 2 spaces
set nojoinspaces
" }}}
" Useful functions {{{

" Via Drew Neil at Vimcasts.org
" Ctrl Shift Q to see the highlight group for word
" Help in creating Vim colorscheme files
" Show syntax highlighting groups for word under cursor
nnoremap <C-S-Q> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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

" My very first Vim function
nnoremap <leader>R :call Ambidextrous()<CR>
function! Ambidextrous()
    echo "This is Ravi's Vim setup"
endfunction

" Capitalize sentence and center it, then move down
" Cannot use it if it's code and the commenting shortcut is set
nnoremap <leader>c :call CapitalizeCenterAndMoveDown()<CR>
function! CapitalizeCenterAndMoveDown()
    s/\<./\u&/g "Built-in substitution capitalizes every word
    center	"Built-in center command centers entire line
    +1	"Built-in relative motion (+1 line down)
endfunction

" From Andrew Burgess/ Gary Bernhardt- open the URL under
" cursor in browser
function! OpenUrlUnderCursor()
    let url=matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    if url != ""
        silent exec "!open '".url."'" | redraw!
    endif
endfunction

map <leader>o :call OpenUrlUnderCursor()<CR>
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
"
" Really not using ; and this saves an additional shift press
" Tip from Damian Conway
nnoremap ; :

" Since I do this so often, making it permanent
" Recording progress during pomodoros
nnoremap <leader>pr A▶<ESC>0

" Copy and paste between different Tmux panes running Vim
" Only visual mode for now for copying
vnoremap <leader>CB :w! ~/.vimbuffer<CR>
nnoremap <leader>PB :r ~/.vimbuffer<CR>
"
" Easier tab management 
nnoremap <leader>Tf :tabfirst<CR>
nnoremap <leader>Tm :tabmove<CR>
nnoremap <leader>Tl :tablast<CR>

" Easily repeat normal command over a visual block
xnoremap . :normal .<CR>

" Easily toggle the first letter on a line between capital and small 
" (easier to type, though the same number of keystrokes)
nnoremap <leader>fl ^~

" Insert checkmark
nnoremap <leader>ch i<C-v>u2713<Esc>

" Easy search and replace for the file or a selection
" Original idea from Damian Conway
nnoremap <leader>S :%s/
vnoremap <leader>S :s/

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

" Since sometimes we have to enforce utf-8
nnoremap <leader>W :w ++enc=utf-8<CR>

" Justifying a paragraph in a simpler way
nnoremap <leader>j gqip

" Toggle spell check
nnoremap <leader>s :set spell!<CR>

" Surrounding the word with single and double quotes
" Courtesy Steve Losh
nnoremap <leader>' viw<ESC>a'<ESC>hbi'<ESC>lel
nnoremap <leader>" viw<ESC>a"<ESC>hbi"<ESC>lel

" Extension - surrounding with (), {}, []
nnoremap <leader>) viw<ESC>a)<ESC>hbi(<ESC>lel
nnoremap <leader>] viw<ESC>a]<ESC>hbi[<ESC>lel
nnoremap <leader>} viw<ESC>a}<ESC>hbi{<ESC>lel

" Use <leader>z to 'focus' the current fold
" Courtesy Steve Losh
nnoremap <leader>z zMzvzz

" 'Make space above and below'
nnoremap <leader>m O<ESC>jo<ESC>k

" Exchange current word and next
nnoremap <leader>xw dWelp

" Toggle background light or dark
nnoremap <leader>bl :set background=light<CR>
nnoremap <leader>bd :set background=dark<CR>

nnoremap <Space> <PageDown>
nnoremap <Tab> <PageUp>
" Insert current date
inoremap <silent> <C-D>d <C-R>=strftime("%e %b %Y")<CR>
" Insert current time
inoremap <silent> <C-D>t <C-R>=strftime("%l:%M %p")<CR>

" Remap H and L, not using the traditional meanings anyway
nnoremap H ^
nnoremap L $

" }}}
" My own matching and highlighting rules {{{
" Make Vim jump between < and > upon pressing % (augment the default)
set matchpairs+=<:>

nnoremap <leader>h :call HighlightTODOs()<CR>

" Making this a function; apparently some colorschemes override this
function! HighlightTODOs()
    highlight MyGroup ctermbg=red guibg=red ctermfg=yellow guifg=yellow term=bold
    match MyGroup /^TODO/
endfunction
" }}}
" Mappings for running things {{{ 
" Running things in Python
nnoremap <leader>pn :sp ./project-notes.txt<CR>
nnoremap <leader>rp :!python %<CR>
nnoremap <leader>rt :!pyrg %<CR>

" Running things in Ruby
nnoremap <leader>rr :!ruby %<CR>

" Running things in JavaScript (Node)
nnoremap <leader>rn :!node %<CR>

" Running an SML program
nnoremap <leader>rm :!sml %<CR>

" Running a Scala script
nnoremap <leader>rs :!scala %<CR>

" Running a GoLang script without building
nnoremap <leader>rg :!go run %<CR>
" }}}
" Commenting and uncommenting {{{
" Commenting - preferable for blocks
vnoremap <leader># :norm I# <CR>
vnoremap <leader>/ :norm I// <CR>

" Better commenting
augroup commenting
	autocmd!
	autocmd filetype python nnoremap <buffer> <leader>c I# <ESC>
	autocmd filetype ruby nnoremap <buffer> <leader>c I# <ESC>
	autocmd filetype perl nnoremap <buffer> <leader>c I# <ESC>
	autocmd filetype java nnoremap <buffer> <leader>c I// <ESC>
	autocmd filetype scala nnoremap <buffer> <leader>c I// <ESC>
	autocmd filetype rust nnoremap <buffer> <leader>c I// <ESC>
	autocmd filetype javascript nnoremap <buffer> <leader>c I// <ESC>
	autocmd filetype c nnoremap <buffer> <leader>c I// <ESC>
	autocmd filetype cpp nnoremap <buffer> <leader>c I// <ESC>
	autocmd filetype cs nnoremap <buffer> <leader>c I// <ESC>
	autocmd filetype tex nnoremap <buffer> <leader>c I% <ESC>
	autocmd filetype sml nnoremap <buffer> <leader>c I(*<SPACE><SPACE><ESC>xA<SPACE>*)<ESC>0
	autocmd filetype html nnoremap <buffer> <leader>c I<!--<ESC>A--><ESC>
	" Add more filetypes as needed  
augroup end

" Uncommenting - preferable for blocks
vnoremap <leader>n# :norm ^2x<CR>
vnoremap <leader>n/ :norm ^3x<CR>

" Better uncommenting 
augroup uncommenting
	autocmd!
	autocmd filetype python nnoremap <buffer> <leader>u ^2x
	autocmd filetype ruby nnoremap <buffer> <leader>u ^2x
	autocmd filetype perl nnoremap <buffer> <leader>u ^2x
	autocmd filetype java nnoremap <buffer> <leader>u ^3x
	autocmd filetype scala nnoremap <buffer> <leader>u ^3x
	autocmd filetype rust nnoremap <buffer> <leader>u ^3x
	autocmd filetype javascript nnoremap <buffer> <leader>u ^3x
	autocmd filetype c nnoremap <buffer> <leader>u ^3x
	autocmd filetype cpp nnoremap <buffer> <leader>u ^3x
	autocmd filetype cs nnoremap <buffer> <leader>u ^3x
	autocmd filetype tex nnoremap <buffer> <leader>u ^2x
	autocmd filetype sml nnoremap <buffer> <leader>u ^3xA<BS><BS><BS><ESC>0
	autocmd filetype html nnoremap <buffer> <leader>u ^4xA<BS><BS><BS><ESC>0
augroup end
" }}}
" Indenting {{{
" Indent the file from top to bottom and leave the cursor at that point
nnoremap <leader>i :norm gg=G<CR>`.
" Round the indent to a multiple of shiftwidth
set shiftround

set autoindent
set copyindent
set smartindent
" }}}
" Common abbreviations {{{
" Note: must disable paste (set nopaste) for abbreviations to work
iabbrev teh the
iabbrev @@ RaviSinha@my.unt.edu
iabbrev adn and
iabbrev thign thing
iabbrev thigns things
iabbrev waht what
iabbrev tehn then
iabbrev wnat want
" Add more as and when needed
"
" Abbreviations specific to the command mode
cnoreabbrev t tabe
cnoreabbrev c colo
cnoreabbrev C0 set colorcolumn=0
cnoreabbrev C1 set colorcolumn=80
" }}}
" Autocmds {{{
" Sourcing your $MYVIMRC makes Vim read your autocmds again, 
" and it has no way of knowing whether it's a duplicate. 
" That makes Vim run slower because it 
" executes the same commands over and over; grouping prevents that
" Event, Pattern, Command

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

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
    autocmd FileType python set tabstop=4
    autocmd FileType python set shiftwidth=4
    autocmd FileType python set softtabstop=4
    " Use spaces, not tabs
    autocmd FileType python set expandtab
augroup END

" Code folding for VimScript files
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldmarker={{{,}}}
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

" Special stuff for Rust
augroup filetype_rust
    autocmd!
    autocmd FileType rust setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
augroup END

" }}}
" {{{ Status bar
" Part from the official Vim page
" Part from Steve Losh's book
" Beautify the status bar
" Currently commented out in favor of airline-vim #Ambidextrous, Aug 11, 2014
set laststatus=2
" set statusline=
" set statusline+=%1*%40F]\ 
" set statusline+=%3*\ [%{&fenc!=''?&fenc:&enc}]\ 
" set statusline+=%1*\ [%Y]\ 
" set statusline+=%4*\ [%05l/%05L:%03c]\ 
" set statusline+=%1*\ [%-16{strftime(\"%Y-%m-%d\ %H:%M\")}]\ 
" set statusline+=%5*\ [%pPC]\ 
"
" Airline stuffs from the customization documentation
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#tabline#enabled = 1
" }}}
" --- not working yet / still creating ---

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

"Set ctags to the newer version installed from SourceForge
"The newer version is exuberant ctags
"Needed to work with Taglist
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
map <F4> :TlistToggle<CR>
"Build tags for the current working directory
map <F5> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"For Michael Sanders' TextMate Snippet Emulator plugin

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
