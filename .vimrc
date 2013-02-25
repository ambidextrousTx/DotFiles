" Ambidextrous
" $MYVIMRC
" Evolving over time
" Latest advancements: Steve Losh's Learn Vimscript the Hard Way

" Tips
" nore = non recursive mappings are better because they never take other mappings into account
" and thus never get into recursive mode. ALWAYS use non recursive mappings
" ---------------------------------------- 

" Greeting at startup
" Cute, but not needed
" echo ">^.^<"

" UTF-8 all the things
set encoding=utf-8

" Autmatically change dirs upon opening
" Only needed/ works for GUI
if has("gui_running")
    set autochdir
endif

" Leader key
let mapleader = ","

" Line numbers
set number          
set numberwidth=4                               " Number of columns for the line numbers

" Start relative number or normal number
nnoremap <leader>, :call SetRelativeNumber()<CR>
nnoremap <leader>. :call SetNumber()<CR>

function! SetNumber()
    set number!                                 " Toggle between number and nonumber
endfunction

function! SetRelativeNumber()
    set relativenumber!                         " Toggle
endfunction
" 
" Make it easier to make it easier to edit text
" Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Since :w mostly becomes :W when done manually
nnoremap <leader>w :w<CR>

" More interesting mappings
" Surrounding the word with single and double quotes
nnoremap <leader>' viw<ESC>a'<ESC>hbi'<ESC>lel
nnoremap <leader>" viw<ESC>a"<ESC>hbi"<ESC>lel

" Commenting
vnoremap <leader># :norm I# <CR>
vnoremap <leader>/ :norm I// <CR>

" Uncommenting
vnoremap <leader>n# :norm ^2x<CR>
vnoremap <leader>n/ :norm ^3x<CR>

" Autocmds
" Sourcing your $MYVIMRC makes Vim read your autocmds again, and it has no way
" of knowing whether it's a duplicate. That makes Vim run slower because it 
" executes the same commands over and over
" Event, Pattern, Command
augroup filetype_python
    autocmd!
    autocmd FileType python set textwidth=79 "PEP-8, set 80 character limit on lines
    " From some plugin to autocomplete Python commands (need to check later)
    autocmd FileType python set omnifunc=pythoncomplete#Complete
augroup END

augroup filetype_html
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal nowrap "Do not wrap HTML documents (local buffer only)
    "Automatically indent HTML before saving
    autocmd BufWritePre *.html normal gg=G 
augroup END

" --- not working yet / still creating ---
"
" From Derek Wyatt's videos, for end of current word changing
" Not always working
set cpoptions+=$
"
" Common abbreviations
iabbrev teh the
iabbrev @@ RaviSinha@my.unt.edu
" Add more as and when needed

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




" Indentation
set shiftround                                  " Round the indent to a multiple of shiftwidth

" General
syntax on
if has("gui_running")
    colorscheme summerfruit256
    set spell
else
    colorscheme default
endif

set nocompatible 	" No compatibility with legacy vi
set showcmd

set go-=T
set hlsearch
set incsearch
set paste
set linebreak " Don't break words on line warp
" Setting spelling only when the GUI is running
"set spell " Turn on automatic spell check 
set foldmethod=manual " Manually fold using zfa} when wanted
set wildmode=longest,list " Shell-style autocomplete

" Split to the bottom and right by default
set splitbelow
set splitright

" Remaps
" Don't need man page brought up
nnoremap K <nop> 

" Using spelling suggestions a bit easily
" Needs spell set
" Adds the dictionary to autocomplete so <C-N> and <C-P> will work without <C-X><C-K> first
set complete-=k complete+=k

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

" For Python
" No tabs in the source file
" All tabs are 4 space characters
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set expandtab		" Use spaces, not tabs

" GUI font, labels on tabs
set guifont=Source\ Code\ Pro:h13
set guitablabel=%N\ %t
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


"Set ctags to the newer version installed from SourceForge
"The newer version is exuberant ctags
"Needed to work with Taglist
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
map <F4> :TlistToggle<CR>
"Build tags for the current working directory
map <F5> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"For Michael Sanders' TextMate Snippet Emulator plugin
filetype plugin on 

" Functions
function! ToggleSyntax()
	if exists("g:syntax_on")
		syntax off
	else
		syntax enable
	endif
endfunction

function! CapitalizeCenterAndMoveDown()
	s/\<./\u&/g "Built-in substitution capitalizes every word
	center	"Built-in center command centers entire line
	+1	"Built-in relative motion (+1 line down)
endfunction

" Mappings
nnoremap <silent> ;s :call ToggleSyntax()<CR>
nnoremap <Space> <PageDown>
nnoremap <Tab> <PageUp>
nnoremap <silent> ;c :call CapitalizeCenterAndMoveDown()<CR>
" Insert current date
inoremap <silent> <C-D><C-D> <C-R>=strftime("%e %b %Y")<CR>
" Insert current time
inoremap <silent> <C-T><C-T> <C-R>=strftime("%l:%M %p")<CR>
" Simple calculator
inoremap <silent> <C-C> <C-R>=string(eval(input("Calculate: ")))<CR>

" Vim Scripts from the official Vim page
" Beautify the status bar
set laststatus=2
set statusline=
set statusline+=%1*%-52F\ 
set statusline+=%2*\ %{&ff=='unix'?'\\n':(&ff=='mac'?'\\r':'\\r\\n')}\ 
set statusline+=%3*\ %{&fenc!=''?&fenc:&enc}\ 
set statusline+=%1*\ %Y\ 
set statusline+=%4*\ %04l/%03c\ 
set statusline+=%2*\ 0x%04.4B\ 
set statusline+=%1*\ %-16{strftime(\"%Y-%m-%d\ %H:%M\")}\ 
set statusline+=%5*\ %-3m\ 


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
