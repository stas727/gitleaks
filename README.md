# Gitleaks sh install

## Install
```console
curl -sSL https://raw.githubusercontent.com/stas727/gitleaks/main/install.sh | sh
```

## Turn on/off

You can use git config variables to turn on/off
Turn on: 
```console
git config gitleaks.enabled true
```

Turn off:
```console
git config gitleaks.enabled false
```

## Integrate

You need to add in your pre commit 
File must be in .git/hooks/pre-commit
If not, there must be a sample file (pre-commit.sample)
After you need to add this in pre-commit file :

```console
getleaks_check () {
    gitleaks protect --staged -v
    # Check the exit code of gitleaks
    if [ $? -ne 0 ]; then
        echo "Gitleaks detected sensitive data. Please fix the issues before committing."
        exit 1
    else
        echo "No sensitive data detected. Proceeding with the commit."
    fi
}
if $(git config gitleaks.enabled); then getleaks_check
fi
```


## How it works

[Docs](https://github.com/gitleaks/gitleaks?tab=readme-ov-file) - gitleaks documentation
