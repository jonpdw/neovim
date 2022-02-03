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
Plug 'junegunn/seoul256.vim'                " Color Scheme
Plug 'tpope/vim-surround'                   " Change surrounding characters
Plug 'unblevable/quick-scope'               " Line find with highlighting
Plug 'jeetsukumaran/vim-indentwise'         " Move to next place same indentation
Plug 'tpope/vim-repeat'                     " Not sure
Plug 'asvetliakov/vim-easymotion'           " Quickly find stuff
Plug 'wellle/targets.vim'                   " Delete arguments object
Plug 'tommcdo/vim-lion'                     " Allign comments
Plug 'michaeljsmith/vim-indent-object'      " Indent object

" Plug 'dbakker/vim-paragraph-motion' 

" " List ends here. Plugins become visible to Vim after this call.
call plug#end()
" ==============================================================
" Settings
" ==============================================================

" Space Leader 
let mapleader=" "

set ignorecase " when searching make it case insensitive 
set smartcase " but if I use capitals then respect them

" ===============================================================
" VSCode 
" ===============================================================

" nnoremap <Leader>r /]);<CR>yi[<C-o>OuseWhatChanged([<C-r>0], "<C-r>0");<ESC>
" nnoremap <Leader>e  ^f[lywouseEffect(() => console.log("useEffect <C-r>0"), [<C-r>0]);<ESC>

" search favorites
nmap <Leader>f <Cmd>call VSCodeCall('favorites.browse')<CR>

nmap <Leader>g <Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>

" serach all files
nmap <Leader>p <Cmd>call VSCodeCall('favorites.browse')<CR>
nmap gl <Cmd>call VSCodeCall('editor.action.openLink')<CR>

" Save and source init.vim
nmap <Leader>s :call VSCodeCall("workbench.action.files.save")<CR>:source $MYVIMRC<CR>

" Go to implimentation
nmap gD :call VSCodeCall("editor.action.goToImplementation")<CR>

" Show popup inline documentation
nmap gp :call VSCodeCall("editor.action.showHover")<CR>

" Move between splits
nmap <Leader>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nmap <Leader>l <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

" Move window to make split
nmap <Leader>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nmap <Leader>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nmap <Leader>k <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
nmap <Leader>j <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>

" Copy laste delete to clipboard
nnoremap <Leader>d :let @0=@"<CR>

" Move without opening fold
nnoremap <A-j> :call VSCodeCall('cursorDown')<CR>
nnoremap <A-k> :call VSCodeCall('cursorUp')<CR>

" don't use the old tab
nnoremap gt <ESC>
nnoremap gT <ESC>

" ===============================================================
" Pure Vim
" ===============================================================
" Open vimrc 
nnoremap <Leader>r :Edit $MYVIMRC<cr>

" when yarking in visual mode put in both system and vim clipboard
vnoremap y ygv"+y

" paste system clipboard
map <Leader>p "+p

" copy everything to the clipboard
" nnoremap <Leader>0 :%y+<CR>
nnoremap <Leader>0 GVgg
nnoremap <C-a> :%y+<CR>

" " Paste last yank 
" nnoremap <Leader>p "0p

" Run macro over selected lines
xnoremap <Leader>q :'<,'>normal! @q<CR>

" Move default register to register a and b
nnoremap <Leader>a :let @a=@"<CR>
nnoremap <Leader>b :let @b=@"<CR>

" Easier end and beginging of line
noremap L $
noremap H ^

" Select inner indentation
nmap <Leader>o vii

" Clear line and indent properly 
nnoremap cc ddko

" Select line but not whitespace and new line
nnoremap <Leader>v ^v$h


" ===============================================================
" Plugins
" ===============================================================

" Easymotion
map s <Plug>(easymotion-s2)
map S <Plug>(easymotion-F2)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Folding
nnoremap zo :call VSCodeNotify("editor.toggleFold")<CR>
nnoremap z[ :call VSCodeNotify("editor.foldRecursively")<CR>
nnoremap z] :call VSCodeNotify("editor.unfoldRecursively")<CR>

nnoremap zz <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

" == IndentWise =================================================

" Move up and down on the same indentation level 
map <Leader>[ <Plug>(IndentWiseBlockScopeBoundaryBegin)
map <Leader>] <Plug>(IndentWiseBlockScopeBoundaryEnd)
 
map } <Plug>(IndentWiseNextEqualIndent)
map { <Plug>(IndentWisePreviousEqualIndent)

" Run map every time a file is loaded as it can get remapped and we want to use [ and ] with no waiting
function! MakeBracketMaps()
    " nnoremap <silent><nowait><buffer> ] <Plug>(IndentWiseNextEqualIndent)
    " nnoremap <silent><nowait><buffer> [ <Plug>(IndentWisePreviousEqualIndent)
    " map <nowait> } <Plug>(IndentWiseNextEqualIndent)
    " map <nowait> { <Plug>(IndentWisePreviousEqualIndent)
    map <nowait> [ <Plug>(IndentWisePreviousLesserIndent) " Move out
    map <nowait> ] <Plug>(IndentWiseNextGreaterIndent) " Move in
    " https://vi.stackexchange.com/a/13406
endfunction

augroup bracketmaps
    autocmd!
    autocmd BufEnter * call MakeBracketMaps()
augroup END

command! FindVSCodeVisualSelectioN call VSCodeNotify('editor.actions.findWithArgs', {'searchString': @p})
vmap <silenct> \f "py<Esc>:FindVSCodeVisualSelectioN<CR>
command! FindVSCode call VSCodeCall('actions.find')
nnoremap <silent> \f "py<Esc>:FindVSCode<CR>

" Open VSCode find in all files 
command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
xnoremap <silent> \s "py<Esc>:FindInFileS<CR>
command! FindInFilesNoInput call VSCodeCall('workbench.action.findInFiles')
nnoremap <silent> \s "py<Esc>:FindInFilesNoInput<CR>

" ===============================================================
" Function
" ===============================================================


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


" ===============================================================
" Removed
" ===============================================================

" cool example showing how to send the visual selection to VSCode
" command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
" xnoremap <silent> <Leader>1 "py<Esc>:FindInFileS<CR>