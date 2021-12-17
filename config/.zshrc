export ZSH="/home/antti/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

eval "$(starship init zsh)"
