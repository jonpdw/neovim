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

" ==============================================================
" Vim Lion
" ==============================================================
" https://github.com/tommcdo/vim-lion
" gl 


" Plug 'dbakker/vim-paragraph-motion' 

" " List ends here. Plugins become visible to Vim after this call.
call plug#end()
" ==============================================================
" Settings
" ==============================================================

" Space Leader 
"  let mapleader="\\"
let mapleader=" "

set ignorecase " when searching make it case insensitive 
set smartcase " but if I use capitals then respect them

" ===============================================================
" VSCode 
" ===============================================================

" nnoremap <Leader>r /]);<CR>yi[<C-o>OuseWhatChanged([<C-r>0], "<C-r>0");<ESC>
" nnoremap <Leader>e  ^f[lywouseEffect(() => console.log("useEffect <C-r>0"), [<C-r>0]);<ESC>

" extract function inside react tsx prop
nmap <Leader>x ?={<CR>llvi{yva{c{extracted}<Esc>?e the old tab
nnoremap gt eturn (<CR>Oconst extracted = ;<Esc>"0P

" Open Gitlens Compare in edit mode
nmap go <Cmd>call VSCodeCall('gitlens.openWorkingFile')<CR>

" search favorites
"  nmap <Leader>f <Cmd>call VSCodeCall('favorites.browse')<CR>

nmap <Leader>g <Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>

" serach all files
nmap <Leader>p <Cmd>call VSCodeCall('favorites.browse')<CR>

nmap g8 <Cmd>call VSCodeCall('editor.action.openLink')<CR>

" Save and source init.vim
nmap <Leader>1 <Cmd>call VSCodeCall("workbench.action.files.save")<CR>:source $MYVIMRC<CR>

" Show popup inline documentation
nmap gp <Cmd>call VSCodeCall("editor.action.showHover")<CR>

" Move between splits
" nmap <Leader>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nmap <Leader>h <Cmd>call VSCodeNotify('multiCommand.moveLeft')<CR>
nmap <Leader>l <Cmd>call VSCodeNotify('multiCommand.moveRight')<CR>

" Move window to make split
nmap <Leader>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nmap <Leader>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nmap <Leader>k <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
nmap <Leader>j <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>

" Copy laste delete to clipboard
nnoremap <Leader>d :let @0=@"<CR>

" Move without opening fold
nnoremap <A-j> <Cmd>call VSCodeCall('cursorDown')<CR>
nnoremap <A-k> <Cmd>call VSCodeCall('cursorUp')<CR>

" don't use the old tab
nnoremap gt <ESC>
nnoremap gT <ESC>

" ===============================================================
" Pure Vim
" ===============================================================

" move lines up and own
" nnoremap K :m .-2<CR>==
" nnoremap J :m .+1<CR>==
" vnoremap K :m '<-2<CR>gv=gv
" vnoremap J :m '>+1<CR>gv=gv
 
" make a console.log with selected text
noremap <Leader>c yoconsole.log("<C-r>0");<ESC>"

" Open vimrc 
nnoremap <Leader>n :Edit $MYVIMRC<cr>

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
"  map <Space> <Plug>(easymotion-s2)
map s <Plug>(easymotion-s2)
map S <Plug>(easymotion-F2)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Folding
nnoremap zo <Cmd>call VSCodeNotify("editor.toggleFold")<CR>
nnoremap z[ <Cmd>call VSCodeNotify("editor.foldRecursively")<CR>
nnoremap z] <Cmd>call VSCodeNotify("editor.unfoldRecursively")<CR>


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


augroup filetype_csharp
    autocmd!
    " Go to the actual implimentation of a method in c# files
    autocmd FileType cs nmap <buffer> gd <Cmd>call VSCodeCall("editor.action.goToImplementation")<CR>
    autocmd FileType cs nmap <buffer> gD <Cmd>call VSCodeCall("editor.action.revealDefinition")<CR>
augroup END

function! QuickNotes()
    %y+
    call VSCodeNotify('workbench.action.revertAndCloseActiveEditor')
endfunction

nnoremap zz <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
" nnoremap zz <Cmd>call QuickNotes()<CR>

augroup quick_notes_close
    autocmd!
    autocmd BufEnter */scratch/*Untitled* nnoremap <buffer> zz <Cmd>call QuickNotes()<Cr>
augroup END

command! FindVSCodeVisualSelection call VSCodeNotify('editor.actions.findWithArgs', {'searchString': @p})
command! FindReplaceVSCodeVisualSelection call VSCodeNotify('editor.actions.findWithArgs', {'searchString': @p, 'replaceString': @p})
command! FindVSCode call VSCodeCall('actions.find')
nnoremap <silent> \f "py<Esc>:FindVSCode<CR>
xnoremap <silent> \f "py<Esc>:FindVSCodeVisualSelection<CR>
xnoremap <silent> \r "py<Esc>:FindReplaceVSCodeVisualSelection<CR>

function! VSCodeReplaceInVisualSelection()
    let startLine = line('v')
    let endLine = line('.')
    call VSCodeNotifyRange('editor.actions.findWithArgs', startLine, endLine, 1, {'searchString': @", 'replaceString': @", 'findInSelection': 'true'})
endfunction

vnoremap \e <cmd>call VSCodeReplaceInVisualSelection()<cr>

" Open VSCode find in all files 
command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
xnoremap <silent> \s "py<Esc>:FindInFileS<CR>

command! FindInFilesNoInput call VSCodeCall('workbench.action.findInFiles')
nnoremap <silent> \s "py<Esc>:FindInFilesNoInput<CR>


function! MoveVisualSelection(direction)
     ": Summary: This calls the editor.action.moveLines and manually recalculates the new visual selection

    let markStartLine = "'<"                     " Special mark for the start line of the previous visual selection
    let markEndLine =   "'>"                     " Special mark for the end line of the previous visual selection
    let startLine = getpos(markStartLine)[1]     " Getpos(mark) => [?, lineNum, colNumber, ?]
    let endLine = getpos(markEndLine)[1]
    let removeVsCodeSelectionAfterCommand = 1    " We set the visual selection manually after this command as otherwise it will use the line numbers that correspond to the old positions
    call VSCodeCallRange('editor.action.moveLines'. a:direction . 'Action', startLine, endLine, removeVsCodeSelectionAfterCommand )

    if a:direction == "Up"                       " Calculate where the new visual selection lines should be
        let newStart = startLine - 1
        let newEnd = endLine - 1
    else ": == 'Down'
        let newStart = startLine + 1
        let newEnd = endLine + 1
    endif

    ": This command basically:
    ": 1. Jumps to the `newStart` line
    ": 2. Makes a linewise visual selection
    ": 3. Jumps to the `newEnd` line
    let newVis = "normal!" . newStart . "GV". newEnd . "G"
    ":                  │  └──────────────────── " The dot combines the strings together
    ":                  └─────────────────────── " ! means don't respect any remaps the user has made when executing
    execute newVis
endfunction

":        ┌───────────────────────────────────── " Exit visual mode otherwise our :call will be '<,'>call
vmap J <Esc>:call MoveVisualSelection("Down")<cr>
vmap K <Esc>:call MoveVisualSelection("Up")<cr>


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


" use vscode for up and down exept when in recording mode
" if exists('g:vscode')
"     nnoremap j <Cmd>call VSCodeCall('cursorDown')<CR>
"     nnoremap k <Cmd>call VSCodeCall('cursorUp')<CR>
" endif
" let g:quickfix_is_open = 0
" function! QuickfixToggle()
"     if g:quickfix_is_open
"         normal! q
"         let @q = @q[:-2] "for some reason a q ends up on the end of the recording
"         nmap j <Cmd>call VSCodeCall('cursorDown')<CR>
"         nmap k <Cmd>call VSCodeCall('cursorUp')<CR>
"         let g:quickfix_is_open = 0
"         echo "-Macro"
"     else
"         normal! qq
"         unmap j
"         unmap k
"         let g:quickfix_is_open = 1
"         echo "+Macro"
"     endif
" endfunction
" nnoremap q <Cmd>call QuickfixToggle()<CR>


" search favorites
" nmap f 
"
" nmap g 
"
" " serach all files
" nmap p 
"
" nmap g8 
"
" " Save and source init.vim
" nmap s :source $MYVIMRC
"
"
" " Show popup inline documentation
" nmap gp 
"
" " Move between splits
" " nmap h 
" nmap h 
" nmap l 
"
" " Move window to make split
" nmap H 
" nmap L 
"
" nmap k 
" nmap j 
"
" " Copy laste delete to clipboard
" nnoremap d :let @0=@"
"
"
" " Move without opening fold
" nnoremap 
