" General
syntax on
if has("gui_running")
    colorscheme summerfruit256
    set spell
else
    colorscheme default
endif
set nocompatible 	" No compatibility with legacy vi
set encoding=utf-8
set showcmd
set number
set go-=T
set hlsearch
set paste
set incsearch
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
nmap <C-S-P> :call <SID>SynStack()<CR>
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

" Ambidextrous
" Some more specific settings for Python
au FileType py set textwidth=79 "PEP-8

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
nmap <silent> ;s :call ToggleSyntax()<CR>
nmap <Space> <PageDown>
nmap <Tab> <PageUp>
nmap <silent> ;c :call CapitalizeCenterAndMoveDown()<CR>
" Insert current date
imap <silent> <C-D><C-D> <C-R>=strftime("%e %b %Y")<CR>
" Insert current time
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M %p")<CR>
" Simple calculator
imap <silent> <C-C> <C-R>=string(eval(input("Calculate: ")))<CR>

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

" Autocmds
autocmd FileType python set omnifunc=pythoncomplete#Complete
