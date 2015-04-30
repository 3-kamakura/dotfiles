# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#### 環境変数設定 ####
# プロンプト表示
export PS1="\[\e[0;36m\][\u@\h \W]\[\e[m\]\$ "

export RSENSE_HOME=$HOME/.vim/opt/rsense-0.3

#### エイリアス設定 ####
alias ll='ls -lah'
alias lll='ll | less'
alias sc='screen'

#### オプション設定 ####
# 補完時に大文字小文字の違いを無視
set completion-ignore-case on

# C-wで「/」を削除しないようにする
stty werase undef
bind '"\C-w": unix-filename-rubout'
