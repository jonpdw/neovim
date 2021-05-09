" https://github.com/asvetliakov/vscode-neovim

" Use PlugInstall to install in a real terminal to install new plugins
" Plugins will be downloaded under the specified directory.
"
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim' "Color Scheme
Plug 'tpope/vim-surround'
Plug 'dbakker/vim-paragraph-motion' 
Plug 'unblevable/quick-scope' 
Plug 'jeetsukumaran/vim-indentwise'
Plug 'tpope/vim-repeat'
Plug 'asvetliakov/vim-easymotion'
Plug 'wellle/targets.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" ($this is a $test,{what is life} this is good )
" Space Leader 
let mapleader=" "

" ===============================================================
" VSCode 
" ===============================================================

" Toggle Parameter hints
nnoremap <Leader>h :call VSCodeCall('parameterHints.toggle')<CR>

" Open url under cursor - (g)o (l)ink
nnoremap gl :call VSCodeCall('editor.action.openLink')<CR>

" Fix moving up (j) and down (k) with folds
if exists('g:vscode')
nnoremap j :call VSCodeCall('cursorDown')<CR>
nnoremap k :call VSCodeCall('cursorUp')<CR>
endif

" Save and source init.vim
nnoremap <Leader>s :call VSCodeCall("workbench.action.files.save")<CR>:source $MYVIMRC<CR>

" ===============================================================
" Pure Vim
" ===============================================================

xnoremap <Leader>q :'<,'>normal! @q<CR>


" Move default register to register a and b
nnoremap <Leader>a :let @a=@"<CR>
nnoremap <Leader>b :let @b=@"<CR>

" Easier end and beginging of line
noremap L $
noremap H ^

" Select a function
nnoremap <Leader>o va{oV

" Clear line and indent properly 
nnoremap cc ddko

" Select line but not whitespace and new line
nnoremap <Leader>v ^v$h


" ===============================================================
" Plugins
" ===============================================================

" Indentwise
map <Leader>j <Plug>(IndentWisePreviousLesserIndent)

" Easymotion
map s <Plug>(easymotion-f2)
map S <Plug>(easymotion-F2)
let g:EasyMotion_smartcase = 1

" Folding
nnoremap zo :call VSCodeNotify("editor.toggleFold")<CR>
nnoremap z[ :call VSCodeNotify("editor.foldRecursively")<CR>
nnoremap z] :call VSCodeNotify("editor.unfoldRecursively")<CR>


" ===============================================================
" Function
" ===============================================================

function! s:findInFiles()
    let startPos = getpos("v")
    let endPos = getpos(".")
    call VSCodeNotifyRangePos("workbench.action.findInFiles", startPos[1], endPos[1], startPos[2], endPos[2], 1)
endfunction

xnoremap <Leader><Leader> l<Cmd>call <SID>findInFiles()<CR>


function! <SID>GotoPattern(pattern, dir) range
    let g:_saved_search_reg = @/
    let l:flags = "We"
    if a:dir == "b"
        let l:flags .= "b"
    endif
    for i in range(v:count1)
        call search(a:pattern, l:flags)
    endfor
    let @/ = g:_saved_search_reg
endfunction

nnoremap <silent> w :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'f')<CR>
vnoremap <silent> w :<C-U>let g:_saved_search_reg=@/<CR>gv/\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv
nnoremap <silent> b :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'b')<CR>
vnoremap <silent> b :<C-U>let g:_saved_search_reg=@/<CR>gv?\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv

" ===============================================================
" Settings
" ===============================================================

" Disable annoying settings when using windows neovim client neovide
let g:neovide_cursor_trail_length=0
let g:neovide_cursor_animation_length=0

" QuickScope settings
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline " Make sure colors work on VScode
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " Only highlight when I press f or t
