let mapleader =" "
" Load Pathogen for plugins:
	execute pathogen#infect()
	execute pathogen#helptags()

" Some basics:
	set nocompatible
	filetype plugin indent on
	syntax on
    "colorscheme wal
    set encoding=utf-8
	set number
	set relativenumber
	set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow
	set splitright

" YouCompleteMe
    if !exists('g:ycm_semantic_triggers')
      let g:ycm_semantic_triggers = {}
    endif
    let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" ClangFormat
    autocmd FileType c,cpp,h ClangFormatAutoEnable

" Vimtex

" Run in shell
	:noremap Q !!$SHELL<CR>

" Shortcutting split navigation, saving a keypress:
	"map <C-h> <C-w>h
	"map <C-j> <C-w>j
	"map <C-k> <C-w>k
	"map <C-l> <C-w>l

" Navigating with guides
	inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	map <Space><Tab> <Esc>/<++><Enter>"_c4l
	inoremap ;gui <++>

" Quick save, quit
	map <leader>w :w<CR><CR>
	map <leader>q :q<CR><CR>

" Open split with vimrc and source it
	nmap <leader>e :tabe ~/.vimrc<CR><CR>
	nmap <leader>s :source ~/.vimrc<CR><CR>

" Fuck arrow keys
	map <Up> :!echo "Idiot"<CR><CR>
	map <Left> :!echo "Idiot"<CR><CR>
	map <Right> :!echo "Idiot"<CR><CR>
	map <Down> :!echo "Idiot"<CR><CR>

" Python
    autocmd FileType python set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
    autocmd Filetype python map <leader>c :!python %<Space>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>
" --- LaTeX Stuff ---

    let g:vimtex_view_method = 'zathura'
    autocmd FileType tex,markdown,rmd set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

" Open corresponding.pdf
	autocmd FileType tex map <leader>o :!evince build/main.pdf &<CR><CR>
        autocmd FileType tex map <leader>O :!evince %:r.pdf &<CR><CR>
    autocmd FileType markdown,rmd map <leader>o :!evince %:r.pdf &<CR><CR>

" Compile document
	autocmd FileType tex map <leader>c :!pdflatex -output-directory build main.tex<CR><CR>
        autocmd FileType tex map <leader>C :!pdflatex % -o %:r.pdf <CR><CR>
	autocmd FileType markdown,rmd map <leader>c :!pandoc % -o %:r.pdf --latex-engine=xelatex --template=pandoc-template.latex -V papersize:a4paper -V fontsize:12pt -V geometry:margin=1in<CR><CR>

" Compile bibtex
    autocmd FileType tex map <leader>b :!bibtex main.aux <CR><CR>

" Compile and display graphviz dot files
    autocmd FileType dot map <leader>c :!dot % -Tpdf -o %:r.pdf<CR><CR>
    autocmd FileType dot map <leader>o :!zathura %:r.pdf &<CR><CR>

"For saving view folds:
	"au BufWinLeave * mkview
	"au BufWinEnter * silent loadview

" Interpret .md files, etc. as .markdown
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Make calcurse notes markdown compatible:
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown

" Get line, word and character counts with F3:
	map <F3> :!wc <C-R>%<CR>

" Spell-check set to F6:
	map <F6> :setlocal spell! spelllang=en_gb<CR>

" Use urlview to choose and open a url:
	:noremap <leader>u :w<Home>silent <End> !urlview<CR>

" Copy selected text to system clipboard (requires xclip installed):
	vnoremap <C-c> "cy<esc>:!echo -n '<C-R>c' \|<space>xclip<CR><enter>

" Goyo plugin makes text more readable when writing prose:
	map <F10> :Goyo<CR>
	map <leader>f :Goyo<CR>
	inoremap <F10> <esc>:Goyo<CR>a

" Enable autocompletion:
	set wildmode=longest,list,full
	set wildmenu

" Automatically deletes all tralling whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear

"""LATEX
	" Word count:
	autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
	autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
	" Compile document using xelatex:
	autocmd FileType tex inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
	autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>

	" Code snippets
	autocmd FileType tex inoremap ;alg \begin{algorithm}<CR>\caption{<CR>\label{alg:<++>}<CR>\begin{algorithmic}[1]<CR>\Function{<++>}{<++>}<CR><++><CR>\EndFunction<CR>\end{algorithmic}<CR>\end{algorithm}<CR><CR><++><Esc>9kA}<Esc>i
	autocmd FileType tex,markdown inoremap ;m $$<++><Esc>F$i
	autocmd FileType tex inoremap ;eqn \begin{equation}<Enter><++><Enter>\end{equation}<Enter><Enter><++><Esc>4kA\label{eqn:}<Esc>i
	autocmd FileType tex inoremap ;lst \begin{lstlisting}<Enter><++><Enter>\end{lstlisting}<Enter><Enter><++><Esc>4kA[float, language=c, caption=""]<Esc>F"i
	autocmd FileType tex inoremap ;fig \begin{figure}<Enter><Space><Space>\centering<Enter><Space><Space>\includegraphics[width=\columnwidth]<Enter><Space><Space>\caption{<++>}<Enter><Space><Space>\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>5kA{}<Esc>T{i

        autocmd FileType tex inoremap ;sfig \begin{figure}<Enter>\centering<Enter>\subfloat[]{\includegraphics[width=\columnwidth*0.4]{}}<Enter>\qquad<Enter>\subfloat[]{\includegraphics[width=\columnwidth*0.4]{<++>}}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>7k$hi

	autocmd FileType tex inoremap ;no \begin{note}<Enter><Enter>\end{note}<Enter><Enter><++><Esc>3ki
	autocmd FileType tex inoremap ;td \begin{note}<Enter>  \begin{itemize}<Enter><Enter>  \end{itemize}<Enter>\end{note}<Enter><Enter><++><Esc>4ki  \item
	autocmd FileType tex inoremap ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ;exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ;glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ;x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA<Space><Space>\item<Space>
	autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA<Space><Space>\item<Space>
	autocmd FileType tex inoremap ;li <Enter>\item<Space>
	autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;tab \begin{tabular}<Enter>\label{<++>}<Enter>\caption{<++>}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>6kA{}<Esc>i
	autocmd FileType tex inoremap ;ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ;can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ;sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;chap \chapter{}<Enter>\label{chap:<++>}<Enter><Enter><++><Esc>3kf}i
	autocmd FileType tex inoremap ;sec \section{}\label{sec:<++>}<Enter><++><Esc>kf}i
	autocmd FileType tex inoremap ;ssec \subsection{}\label{ssec:<++>}<Enter><++><Esc>kf}i
	autocmd FileType tex inoremap ;sssec \subsubsection{}\label{sssec:<++>}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ;beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ;up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ;tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;bt {\blindtext}
	autocmd FileType tex inoremap ;nu $\varnothing$
	autocmd FileType tex inoremap ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ;rn (\ref{})<++><Esc>F}i

"MARKDOWN
"	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ;n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ;b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ;s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ;e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ;h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ;i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ;a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ;1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ;2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ;3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ;l --------<Enter>
	autocmd Filetype markdown map <F5> :!pandoc<space><C-r>%<space>--pdf-engine=xelatex<space>-o<space><C-r>%.pdf<Enter><Enter>
	autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
	autocmd Filetype rmd inoremap ;r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ;p ```{python}<CR>```<CR><CR><esc>2kO

