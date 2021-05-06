" https://github.com/asvetliakov/vscode-neovim
" Use PlugInstall to install in a real terminal to install new plugins

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim' "Color Scheme
Plug '/tpope/vim-surround'
Plug 'dbakker/vim-paragraph-motion' "Ignore whitespace when doing paragraph jump
Plug '/unblevable/quick-scope' "When f pressed highlight which letter to go to each word
Plug 'jeetsukumaran/vim-indentwise'
Plug '/tpope/vim-repeat'
Plug '/asvetliakov/vim-easymotion'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:neovide_cursor_trail_length=0
let g:neovide_cursor_animation_length=0


" QuickScope settings
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline " Make sure colors work on VScode
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " Only highlight when I press f or t

" Folding
nnoremap zo :call VSCodeNotify("editor.toggleFold")<CR>
nnoremap z[ :call VSCodeNotify("editor.foldRecursively")<CR>
nnoremap z] :call VSCodeNotify("editor.unfoldRecursively")<CR>

" Fix moving up (j) and down (k) with folds
if exists('g:vscode')
nnoremap j :call VSCodeCall('cursorDown')<CR>
nnoremap k :call VSCodeCall('cursorUp')<CR>
endif

" Space Leader 
let mapleader=" "

nnoremap <Leader>s :call VSCodeCall("workbench.action.files.save")<CR>:source C:\Users\jonathan.dewet\AppData\Local\nvim\init.vim<CR>

function! s:showCommands()
    let startPos = getpos("v")
    let endPos = getpos(".")
    call VSCodeNotifyRangePos("workbench.action.findInFiles", startPos[1], endPos[1], startPos[2], endPos[2], 1)
endfunction

xnoremap <Leader><Leader> <Cmd>call <SID>showCommands()<CR>
" xnoremap <C-c> <Cmd>call <SID>showCommands()<CR>




map s <Plug>(easymotion-f2)
map S <Plug>(easymotion-F2)

nnoremap cc ddko
nnoremap <Leader>v ^v$h
noremap L $
noremap H ^

let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(IndentWisePreviousLesserIndent)

" Move default register to register a and b
nnoremap <Leader>a :let @a=@"<CR>
nnoremap <Leader>b :let @b=@"<CR>

" Select a function
nnoremap <Leader>o va{oV

noremap <Leader>i :call VSCodeNotify("workbench.action.quickOpen", "/\Users/\jonathan.dewet/\AppData\Local\nvim\init.vim")



" " <SPACE>   : forward to next word beginning with alphanumeric char
" " <S-SPACE> : backward to prev word beginning with alphanumeric char
" " <C-SPACE> : same as above (as <S-SPACE> not available in console Vim
" " <BS>      : back to prev word ending with alphanumeric char
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