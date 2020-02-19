set clipboard=unnamed
set number
syntax on 
set wrap!
set ts=4

if has('win32')
elseif has('unix')
    " linux下复制到系统剪贴板
    map "+y :w !xclip -selection c<CR><CR>
elseif has('mac')
    " mac下复制到系统剪贴板
    map "+y :w !pbcopy<CR><CR>
    map "+p :r !pbpaste<CR><CR> 
endif