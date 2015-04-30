"---------------------------
" Neobundle Settings
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

"---------------------------
" 管理モジュール一覧
"---------------------------
" カラースキーマ
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'chriskempson/vim-tomorrow-theme'

" 一般
NeoBundle 'nathanaelkane/vim-indent-guides'

" 開発全般
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'szw/vim-tags'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-endwise'
NeoBundle "tyru/caw.vim.git"

" Rails関係
NeoBundle 'romanvbabenko/rails.vim'

call neobundle#end()

"---------------------------
" neocomplete用設定
"---------------------------
" 補完ウィンドウの設定
set completeopt=menuone
let g:acp_enableAtStartup = 0
" 起動時に有効化
let g:neocomplete#enable_at_startup = 1
" 補完候補検索時に大文字・小文字を無視する
let g:neocomplete#enable_ignore_case = 1
" 補完が自動で開始される文字数
let g:neocomplete#auto_completion_start_length = 3
" -入力による候補番号の表示
let g:neocomplete#enable_quick_match = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplete#max_list = 20
" シンタックスをキャッシュするときの最小文字長を3に
" let g:neocomplete#min_syntax_length = 3
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#enable_camel_case = 0

"補完するためのキーワードパターンを指定
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif

"カーソルより後のキーワードパターンを認識。
""h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif

" tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" C-jで補完ウィンドウを閉じる(改行無し)
inoremap <expr><C-j> neocomplete#smart_close_popup()
"C-h, BSで補完ウィンドウを確実に閉じる
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<BS>"

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" スニペットファイルの場所指定
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" Plugin key-mappings.  " <C-k>でsnippetの展開
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" 辞書登録
let g:neocomplete#keyword_patterns._ = '\h\w*'
let g:neocomplete#sources#dictionary = $RSENSE_HOME
let $VIMHOME = $HOME . '/.vim'
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'rb' : $VIMHOME.'/dict/ruby.dict'
\ }

" ファイル名で区別出来る場合は直接呼び出し
" ファイル名で区別できない場合は一旦関数に投げる
augroup filetypedetect
  autocmd!  BufEnter *rb call s:LoadRailsSnippet()
augroup END

" rails用スニペット呼び出し関数
function! s:LoadRailsSnippet()
  " カレントディレクトリのディレクトリパス（絶対パス）取得
  let s:current_file_path = expand("%:p:h")
  " specフォルダ内ならば
  if ( s:current_file_path =~ "spec/" )
    NeoSnippetSource ~/.vim/snippets/ruby_snip/ruby.rails.rspec.snip
  " appフォルダ内でなければ無視
  elseif ( s:current_file_path !~ "app/" )
    return
  " app/modelsフォルダ内ならば
  elseif ( s:current_file_path =~ "app/models" )
    NeoSnippetSource ~/.vim/snippets/ruby_snip/ruby.rails.model.snip
  " app/controllersフォルダ内ならば
  elseif ( s:current_file_path =~ "app/controllers" )
    NeoSnippetSource ~/.vim/snippets/ruby_snip/ruby.rails.controller.snip
  " app/viewsフォルダ内ならば
  elseif ( s:current_file_path =~ "app/views" )
    NeoSnippetSource ~/.vim/snippets/ruby_snip/ruby.rails.view.snip
    NeoSnippetSource ~/.vim/snippets/vim-snippets/html.snippets
  endif
endfunction

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=238
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=2

" vim-tags
let g:vim_tags_project_tags_command = "ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
"au BufNewFile,BufRead *.rb let g:vim_tags_project_tags_command = \"ctags --languages=ruby -f ~/tags/ruby.tags `pwd` 2>/dev/null &"

nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)

" colorscheme
syntax on
colorscheme Tomorrow-Night-Bright

filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

"-------------------------
" Vim基本設定
"-------------------------
set encoding=utf-8
set fileencoding=utf-8

set showmatch         " 括弧の対応をハイライト
set number            " 行番号を表示
set ruler             " カーソル位置を右下に表示
set nowrap            " 画面幅で折り返さない

set cursorline        " カーソル行をハイライト

set wildmenu          " コマンド補完を強化
set laststatus=2      " ステータスを2行表示に

set selection=exclusive

set list
set listchars=tab:>\

" ---------- Search ----------
set wrapscan          " 最後まで検索したら先頭へ戻る
set ignorecase        " 大文字小文字無視
set smartcase         " 大文字ではじめたら大文字小文字無視しない
set hlsearch          " 検索文字をハイライト


" ---------- Tab ----------
set expandtab         " Tabを半角スペースに置き換える
set tabstop=2         " Tabを押した時の半角スペースの数
set shiftwidth=2
set softtabstop=2

" Backspaceを調整
set backspace=indent,eol,start

" ---------- KeyMap ----------
nnoremap <Esc><Esc> :<C-u>noh<Return>
nnoremap gb gT
nnoremap <C-e> :NERDTree<Return>
nnoremap <C-n> :tabnew<CR>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>

augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" 括弧類の自動補完
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" vnoremap { "zdi^V{<C-R>z}<ESC>
" vnoremap [ "zdi^V[<C-R>z]<ESC>
" vnoremap ( "zdi^V(<C-R>z)<ESC>
" vnoremap " "zdi^V"<C-R>z^V"<ESC>
" vnoremap ' "zdi'<C-R>z'<ESC>

" ---------- colorscheme ----------
hi LineNr ctermfg=244

hi Pmenu ctermbg=237
hi PmenuSel ctermfg=33 ctermbg=220
hi PMenuSbar ctermbg=4
hi Visual cterm=reverse ctermfg=32 ctermbg=220
hi Search cterm=reverse ctermfg=32 ctermbg=220
hi IncSearch cterm=reverse ctermfg=160 ctermbg=220
