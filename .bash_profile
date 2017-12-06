#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# If ~/bin exists and is a directory, and is not already in your $PATH
# then export ~/bin to your $PATH.
if [[ -d "$HOME/bin" && -z $(echo $PATH | grep -o "$HOME/bin") ]]; then
	export PATH="$HOME/bin:$PATH"
fi
