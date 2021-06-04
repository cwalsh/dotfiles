source ~/.bashrc

ssh-add -A &> /dev/null

source ~/.profile

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cameron.walsh/google-cloud-sdk/path.bash.inc' ]; then source '/Users/cameron.walsh/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cameron.walsh/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/cameron.walsh/google-cloud-sdk/completion.bash.inc'; fi
