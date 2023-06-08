" ==============================================================
" Tips
" ==============================================================
" 
" To use vim lion (align things) press gl
" https://github.com/tommcdo/vim-lion
"
"

" https://github.com/asvetliakov/vscode-neovim

" Use PlugInstall to install in a real terminal to install new plugins

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'                " Color Scheme
Plug 'tpope/vim-surround'                   " Change surrounding characters
Plug 'unblevable/quick-scope'               " Line find with highlighting
Plug 'tpope/vim-repeat'                     " Not sure
Plug 'asvetliakov/vim-easymotion'           " Quickly find stuff
Plug 'wellle/targets.vim'                   " Delete arguments object
Plug 'tommcdo/vim-lion'                     " Align comments
Plug 'michaeljsmith/vim-indent-object'      " Indent object

call plug#end()

" ==============================================================
" Settings
" ==============================================================

" Space Leader 
let mapleader=" "

" When searching make it case insensitive 
set ignorecase 

" When searching if I use capitals then respect them
set smartcase 

" ===============================================================
" VSCode 
" ===============================================================

" run quokka once
nmap <Leader>r <Cmd>call VSCodeCall("quokka.runOnce")<CR>

" extract function inside react tsx prop
nmap <Leader>x ?={<CR>llvi{yva{c{extracted}<Esc>?e the old tab
nnoremap gt eturn (<CR>Oconst extracted = ;<Esc>"0P

" Open Gitlens Compare in edit mode
nmap go <Cmd>call VSCodeCall('gitlens.openWorkingFile')<CR>

" Open link under cursor in a browser
nmap g8 <Cmd>call VSCodeCall('editor.action.openLink')<CR>

" Save and source init.vim
nmap <Leader>1 <Cmd>call VSCodeCall("workbench.action.files.save")<CR>:source $MYVIMRC<CR>

" Show popup inline documentation
nmap gp <Cmd>call VSCodeCall("editor.action.showHover")<CR>

nmap <Leader>g <Cmd>call VSCodeCall("editor.action.triggerParameterHints")<CR>

" Move between splits
nmap <Leader>h <Cmd>call VSCodeNotify('multiCommand.moveLeft')<CR>
nmap <Leader>l <Cmd>call VSCodeNotify('multiCommand.moveRight')<CR>

" Move window to make split
nmap <Leader>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nmap <Leader>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nmap <Leader>k <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
nmap <Leader>j <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>

" Move without opening fold
nnoremap <A-j> <Cmd>call VSCodeCall('cursorDown')<CR>
nnoremap <A-k> <Cmd>call VSCodeCall('cursorUp')<CR>

" Folding
nnoremap zo <Cmd>call VSCodeNotify("editor.toggleFold")<CR>
nnoremap z[ <Cmd>call VSCodeNotify("editor.foldRecursively")<CR>
nnoremap z] <Cmd>call VSCodeNotify("editor.unfoldRecursively")<CR>

" Close active editor window
nnoremap zz <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

" Search using vscode search
command! FindVSCode call VSCodeCall('actions.find')
nnoremap <silent> \f "py<Esc>:FindVSCode<CR>

" Search using vscode search using the current visual selection as the search
command! FindVSCodeVisualSelection call VSCodeNotify('editor.actions.findWithArgs', {'searchString': @p})
xnoremap <silent> \f "py<Esc>:FindVSCodeVisualSelection<CR>

" Do a find and replace in vscode using the current visual selection as the search
command! FindReplaceVSCodeVisualSelection call VSCodeNotify('editor.actions.findWithArgs', {'searchString': @p, 'replaceString': @p})
xnoremap <silent> \r "py<Esc>:FindReplaceVSCodeVisualSelection<CR>

" Open VSCode find in all files (normal mode)
command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
xnoremap <silent> \s "py<Esc>:FindInFileS<CR>

" Open VSCode find in all files (visual mode)
command! FindInFilesNoInput call VSCodeCall('workbench.action.findInFiles')
nnoremap <silent> \s "py<Esc>:FindInFilesNoInput<CR>

" Vscode Replace with Visual Selection
vnoremap \e <cmd>call VSCodeReplaceInVisualSelection()<cr>

" Copy current path and line number to the clipboard
nnoremap <Leader>a <Cmd>call VSCodeCall('extension.copyRelativePathWithLineNumber')<CR>
 

"  function! OpenActiveFile()
"      " Get the current file and line number
"      let current_file = expand('%:p')
"      let current_line = line('.')

"      " Close the VSCode diff view
"      call VSCodeCall('workbench.action.closeActiveEditor')

"      " Open the active file from step 1 by itself
"      let file_uri = 'file://' . current_file
"      call VSCodeExtensionNotify('open-file', file_uri)

"      " Move to the line number
"      execute 'normal! ' . current_line . 'G'
"  endfunction

" Map the function to a keybinding
"  nnoremap go :call OpenActiveFile()<CR>
" ===============================================================
" Pure Vim
" ===============================================================

" Make a console.log with selected text
noremap <Leader>c yoconsole.log("<C-r>0");<ESC>"

" Open vscode global snippet file
nnoremap <Leader>s :Edit c:\Users\jonathan.dewet\AppData\Roaming\Code\User\snippets/globalTest.code-snippets<cr>

" Open scratch/main.txt
"  nnoremap <Leader>3 <Cmd>call VSCodeCall('copy-relative-path-and-line-numbers.both')<CR>:Edit C:\Personal_Git\scratch\main.txt<cr>
nnoremap <Leader>3 :Edit C:\Personal_Git\scratch\main.txt<cr>

" Open vimrc 
nnoremap <Leader>n :Edit $MYVIMRC<cr>

" When yanking in visual mode put in both system and vim clipboard
vnoremap y ygv"+y

" Paste system clipboard
map <Leader>p "+p

" Visual select everything
nnoremap <Leader>0 GVgg

" Copy everything into the clipboard (Ctrl+a)
nnoremap <C-a> :%y+<CR>

" Run macro over selected lines
xnoremap <Leader>q :'<,'>normal! @q<CR>

" Easier end and beginning of line
noremap L $
noremap H ^

" Select inner indentation
nmap <Leader>o vii

" Clear line and indent properly 
nnoremap cc ddko

" Select line but not whitespace and new line
nnoremap <Leader>v ^v$h

" Improved back and forward by word
nnoremap <silent> w :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'f')<CR>
    
vnoremap <silent> w :<C-U>let g:_saved_search_reg=@/<CR>gv/\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv

nnoremap <silent> b :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'b')<CR>
vnoremap <silent> b :<C-U>let g:_saved_search_reg=@/<CR>gv?\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv


" toggle "//?" from the end of the current line
" e.g. "console.log('hello world'); //?" -> "console.log('hello world');"
" e.g. "console.log('hello world');" -> "console.log('hello world'); //?"
nnoremap <silent> <leader>d :<C-U>call ToggleCommentWithQuestionMark()<CR>

function ToggleCommentWithQuestionMark()
    let l:line = getline('.') " get current line
    let l:comment = '//?' " comment to toggle
    let l:commented = l:line =~ '//?' ? 1 : 0 " check if line is commented
    if l:commented
        let l:line = substitute(l:line, '//?', '', '') " remove comment
    else
        " trim whitespace from the end of the line
        let l:line = substitute(l:line, '\s\+$', '', '')
        let l:line = l:line . ' //?' " add comment
    endif
    call setline('.', l:line) " set line
endfunction




" ===============================================================
" Plugins
" ===============================================================

" == Easymotion ==
"  map <Space> <Plug>(easymotion-s2)
map s <Plug>(easymotion-s2)
map S <Plug>(easymotion-F2)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1


" ===============================================================
" AutoGroups 
" ===============================================================

" Better go to definition in C#
augroup filetype_csharp
    autocmd!
    " Go to the actual implementation of a method in c# files
    autocmd FileType cs nmap <buffer> gD <Cmd>call VSCodeCall("editor.action.goToImplementation")<CR>
    autocmd FileType cs nmap <buffer> gd <Cmd>call VSCodeCall("editor.action.revealDefinition")<CR>
augroup END


" Don't ask to save when closing a scratch buffer
augroup quick_notes_close
    autocmd!
    autocmd BufEnter */scratch/*Untitled* nnoremap <buffer> zz <Cmd>call QuickNotes()<Cr>
augroup END

" ===============================================================
" Functions
" ===============================================================

function! QuickNotes()
    %y+
    call VSCodeNotify('workbench.action.revertAndCloseActiveEditor')
endfunction

function! VSCodeReplaceInVisualSelection()
    let startLine = line('v')
    let endLine = line('.')
    call VSCodeNotifyRange('editor.actions.findWithArgs', startLine, endLine, 1, {'searchString': @", 'replaceString': @", 'findInSelection': 'true'})
endfunction

function! <SID>GotoPattern(pattern, dir) range
    " set magic
    let g:_saved_search_reg = @/
    let l:flags = "We"
    if a:dir == "b"
        let l:flags .= "b"
    endif
    for i in range(v:count1)
        call search(a:pattern, l:flags)
    endfor
    let @/ = g:_saved_search_reg
    " set nomagic
endfunction


" ===============================================================
" Settings
" ===============================================================

" Disable annoying settings when using windows neovim client neovide
let g:neovide_cursor_trail_length=0
let g:neovide_cursor_animation_length=0

imap <C-V> <C-R><C-P>+
nnoremap <C-s> :w<CR>
"  " only when in qtvim (windows neovim client)
"  if exists('g:GuiLoaded')
    "  noremap <C-v> "+gP
    "  vnoremap <C-v> "+gP
    "  noremap <C-c> "+y
    "  vnoremap <C-c> "+y
"  endif

"  " Configure closing the window to copy text to the clipboard and not throw any errors
"  augroup CloseWindowCopy
"    autocmd!
"    autocmd BufWinLeave * silent! execute 'normal! ggVGy' | silent! w | silent! q
"  augroup END

" QuickScope settings
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline " Make sure colors work on VScode
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " Only highlight when I press f or t

