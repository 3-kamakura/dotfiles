# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# PATH設定
export RSENSE_HOME=$HOME/.vim/opt/rsense-0.3

# プロンプト表示の変更
export PS1="\[\e[0;36m\][\u@\h \W]\[\e[m\]\$ "

# 補完時に大文字小文字の違いを無視
set completion-ignore-case on

# エイリアスを追加
alias ll='ls -lah'
alias lll='ll | less'
alias sc='screen'
