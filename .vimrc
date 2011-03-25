
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Nov 16
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		autocmd BufReadPost *
					\ if line("'\"") > 0 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
			\ | wincmd p | diffthis

" CONFIGURACIONES PERSONALES
language en_US.UTF-8
set langmenu='en_US.UTF-8'
set spelllang=es
set listchars=tab:»·,trail:·
set list
set tabstop=4
set shiftwidth=4
set ignorecase
set mousemodel=popup
set foldcolumn=1
set foldenable
set number
set diffopt=vertical
set foldlevel=10

"autocmd FileType ruby,eruby set tabstop=2 | set shiftwidth=2 | set expandtab |
"			\ let g:rubycomplete_buffer_loading = 1 | let g:rubycomplete_rails = 1 | let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby set tabstop=2 | set shiftwidth=2 | set expandtab | 
			\ set foldmethod=syntax | let g:xptemplate_brace_complete = '|([{<"''' | 
      \ let g:rubycomplete_rails = 1 | let g:rubycomplete_classes_in_global = 1 | let g:rubycomplete_buffer_loading = 1
autocmd FileType html,xhtml,xml set tabstop=2 | set shiftwidth=2 | set expandtab |
			\ map <F12> :%!tidy -config ~/.tidyrc -q -i -f errors.err<CR> | 
			\ compiler tidy
autocmd FileType python set expandtab | set tabstop=4 | set shiftwidth=4 | set foldmethod=syntax
autocmd FileType java setlocal omnifunc=javacomplete#Complete | set foldmethod=syntax
autocmd FileType c,cpp set nocp
autocmd FileType css compiler css
autocmd FileType * let g:xptemplate_brace_complete = '([{<"'''

"set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=B  "remove bottom scroll bar
set guifont=DejaVu\ Sans\ Mono\ 10

map <F4> <ESC>:TrinityToggleAll<CR>
map <F2> <ESC>:TrinityToggleNERDTree<CR>
map <F3> <ESC>\be
map <F5> <ESC>:FufFile**/<CR>
map <F6> <ESC>:Errors<CR>
map <F7> <ESC>:TrinityToggleTagList<CR>
map <F8> <ESC>:!gcolor2<CR>

" first, enable status line always
set laststatus=2
set pastetoggle=<F11>

imap <C-@> <C-space>
imap <C-b> <space>=> 
imap <C-space> <C-x><C-o>

let g:netrw_ftp_cmd="ftp -p"
let g:user_zen_expandabbr_key = '<c-e>'
let g:GetLatestVimScripts_allowautoinstall=1
let g:acp_enableAtStartup = 1


if $TERM == 'xterm'
	"set t_Co=256
	"colorscheme pyte
	set nocursorline
elseif $TERM == 'linux'
	colorscheme default
	set nocursorline
elseif $TERM == ''
	colorscheme molokai
""	autocmd InsertLeave * hi StatusLineNC term=reverse ctermfg=59 ctermbg=145 gui=italic guifg=#506070 guibg=#a0b0c0 |
""				\ hi StatusLine term=bold,reverse cterm=bold ctermfg=231 ctermbg=103 gui=bold,italic guifg=white guibg=#8090a0 |
""				\ hi SpecialKey term=bold ctermfg=181 ctermbg=255 guifg=#d0b0b0 guibg=#f0f0f0
	set lines=45 columns=120
endif

set laststatus=2
"
"Enable omni completion. 
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 


let g:user_zen_settings = {
			\  'php' : {
			\    'extends' : 'html',
			\    'filters' : 'c',
			\  },
			\  'xml' : {
			\    'extends' : 'html',
			\  },
			\  'haml' : {
			\    'extends' : 'html',
			\  },
			\  'lang' : "es"
			\}

let g:xptemplate_brace_complete = '([{<"'''
let g:xptemplate_key = '<Tab>'
let g:acp_mappingDriven = 1

