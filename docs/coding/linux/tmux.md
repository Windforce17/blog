## tmux

tmux 是以 session、Windows、panel 为基础的。 window 可以切割为不同的 panel，我个人喜欢单独开一个 Window，屏幕小没办法..
tmux 中的快捷键是有前缀的，默认是`ctrl+b`.

## config

```
#below reset tmux prefix command key
set -g prefix C-x
unbind C-b
bind C-x send-prefix
#set swap pane key
bind-key k select-pane -U
bind-key j select-pane -D
bind-key h select-pane -L
bind-key l select-pane -R
```

将`ctrl+b` 改为了`ctrl+x`

## 快捷键

`tmux` 新建一个默认 session，名字就是编号，需要名字则`tmux new -S <name>`
`ctrl+x d` 相当于`tmux detach`,注意此时 session 并没有关闭，只是在后台。
`tmux ls`查看 session 列表。
`tmux a -t
