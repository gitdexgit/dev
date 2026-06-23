
" really awesome ones that I use and love to use
unmap <Space>
set clipboard=unnamed

noremap j gj
noremap k gk
nmap H g0
nmap M g^
nmap L g$

exmap toggleLeftSidebar obcommand app:toggle-left-sidebar
nnoremap <Space>h :toggleLeftSidebar<CR>

exmap toggleRightSidebar obcommand app:toggle-right-sidebar
nnoremap <Space>l :toggleRightSidebar<CR>

exmap toggleFocusMode obcommand obsidian-focus-mode:toggle-focus-mode
nnoremap <Space>f :toggleFocusMode<CR>

nmap <Space>noh :nohl<CR>

exmap togglefold obcommand editor:toggle-fold
nmap za :togglefold<CR>

exmap toggleFoldAll obcommand editor:fold-all
nnoremap zM :toggleFoldAll<CR>

exmap toggleFoldUnfoldAll obcommand editor:unfold-all
nnoremap zR :toggleFoldUnfoldAll<CR>

"requires the vimimu plugin to be enabled

"I dont use this anymore
"exmap ShowVimiumMarkers obcommand vimium:show-markers
"nmap <Space>f :ShowVimiumMarkers<CR>gi


"inoremap jjk <Esc>

"This is huge and I like it but like idk if gl is used
"exmap followLink obcommand editor:follow-link
"nnoremap gl :followLink<CR>

" file explorer

"The heck is even this I don't use this bs
"exmap toggleFileExplorerOpen obcommand file-explorer:open
"nnoremap <Space>fe :toggleFileExplorerOpen<CR>
"
"exmap toggleFileExplorerReveal obcommand file-explorer:reveal-active-file
"nnoremap <Space>fr :toggleFileExplorerReveal<CR>
