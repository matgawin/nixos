{pkgs, ...}: {
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      syntax on
      let mapleader = " "
      let maplocalleader = " "
      set timeoutlen=500
      set foldmethod=syntax

      set undofile
      set undodir=~/.config/vim/undo//

      set wildmode=longest:full,full
      set hlsearch
      set lazyredraw
      set showmatch

      set noerrorbells
      set novisualbell
      set t_vb=
      set tm=500

      set expandtab
      set shiftwidth=4
      set tabstop=4
      set shiftround
      set nojoinspaces
      set colorcolumn=120

      set nobackup
      set nowb
      set noswapfile

      set clipboard=unnamedplus

      set hidden
      set confirm

      set list
      set lcs=
      set lcs+=space:·,tab:-»,trail:•

      " Cursor configuration
      set guicursor=n-v-c:block,i-ci-ve:hor20,r-cr:hor20,o:hor50
      let &t_SI = "\e[6 q"
      let &t_EI = "\e[2 q"

      colorscheme nord

      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#buffer_nr_show = 1
      let g:airline#extensions#tabline#formatter = 'unique_tail'

      let g:move_key_modifier = 'C'

      " Goyo
      let g:goyo_width = 130
      let g:goyo_height = '100%'
      let g:goyo_linenr = 1
      nnoremap <leader>g :Goyo<CR>
      autocmd! User GoyoEnter Copilot disable
      autocmd! User GoyoEnter Limelight
      autocmd! User GoyoLeave Copilot enable
      autocmd! User GoyoLeave Limelight!

      let g:NERDCreateDefaultMappings = 0
      map gcc <plug>NERDCommenterToggle

      nnoremap <leader>n :NERDTreeFocus<CR>
      nnoremap <C-n> :NERDTree<CR>
      nnoremap <C-t> :NERDTreeToggle<CR>
      nnoremap <C-f> :NERDTreeFind<CR>

      nnoremap <leader>s :setlocal spell!<CR>

      nnoremap <F5> :MundoToggle<CR>
      let g:mundo_right = 1

      inoremap <c-u> <c-g>u<c-u>
      inoremap <c-w> <c-g>u<c-w>
      inoremap . <c-g>u.

      nnoremap ]b :bnext<CR>
      nnoremap [b :bprevious<CR>

      nnoremap <leader>1 :b1<CR>
      nnoremap <leader>2 :b2<CR>
      nnoremap <leader>3 :b3<CR>
      nnoremap <leader>4 :b4<CR>
      nnoremap <leader>5 :b5<CR>

      nnoremap \ :WhichKey '''<CR>

      function! SmartBufferQuit(save, force)
        let num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
        let force_flag = a:force ? '!' : '''

        if num_buffers > 1
          if a:save
            execute 'write | bdelete' . force_flag
          else
            execute 'bdelete' . force_flag
          endif
        else
          if a:save
            execute 'write | quit' . force_flag
          else
            execute 'quit' . force_flag
          endif
        endif
      endfunction

      nnoremap ZZ :call SmartBufferQuit(1, 0)<CR>
      nnoremap ZQ :call SmartBufferQuit(0, 1)<CR>
      cnoreabbrev q call SmartBufferQuit(0, 0)
      cnoreabbrev q! call SmartBufferQuit(0, 1)
      cnoreabbrev wq call SmartBufferQuit(1, 0)
      cnoreabbrev wq! call SmartBufferQuit(1, 1)

      nnoremap \ :WhichKey '''<CR>

      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
      autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
    '';
    plugins = with pkgs.vimPlugins; [
      awesome-vim-colorschemes
      bufexplorer
      ctrlp-vim
      copilot-vim
      goyo-vim
      fzf-vim
      limelight-vim
      nerdtree
      nerdcommenter
      vim-airline
      vim-autoformat
      vim-easy-align
      vim-easymotion
      vim-gitgutter
      vim-highlightedyank
      vim-lastplace
      vim-lsp
      vim-lsp-settings
      vim-move
      vim-mundo
      vim-nix
      vim-orgmode
      vim-peekaboo
      vim-sensible
      vim-signature
      vim-smoothie
      vim-sneak
      vim-surround
      vim-visual-multi
      vim-which-key
      vimagit
    ];
    settings = {
      background = "dark";
      mousefocus = true;
      relativenumber = true;
      smartcase = true;
      history = 1000;
    };
  };
}
