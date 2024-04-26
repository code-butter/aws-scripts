# aws-scripts
Shell scripts to make dealing with common AWS tasks easier. You will need a bash shell available (version 5+)

## General Setup

* Clone this repo. Make note of where you saved it for later steps.
* Download [selektor](https://github.com/code-butter/selektor) and put in your $PATH

# Scripts

## aws-profile
Switches between available profiles quickly

### Setup
In a shell profile, put the following code: 

```
aws-profile() {
    src=$(/path/to/aws-scripts/aws-profile.sh "$@")
    eval "$src"   
}
```

File locations for shells:
 
* zsh: ~/.zshenv
* bash: ~/.bash_profile

### Arguments

* `list` Lists all available CLI profiles
* `select` Select a profile. You can provide an additional argument to select an existing profile. If you omit this, it
    uses selektor to show options in a UI. 
* `login` Use AWS SSO to log into an existing profile. It behaves similarly to `select` 
