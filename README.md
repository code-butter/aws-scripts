# aws-scripts
Shell scripts to make dealing with common AWS tasks easier. You will need a bash shell available (version 5+)

## General Setup

* Clone this repo. Make note of where you saved it for later steps.
* Download selektor and put in your $PATH

# Scripts

## aws-profile
Switches between available profiles quickly

### Setup
In a shell profile, put the following code: 

```
aws-profile() {
    src=$(/path/to/aws-scripts/aws-profile "$@")
    eval "$src"   
}
```

File locations for shells:
 
* zsh: ~/.zshenv
* bash: ~/.bash_profile

### Arguments

You can pass `list` or `select`. If you pass an additional argument to `select` it will select that profile for you. If
you do not, the script will pop up with available profiles.
