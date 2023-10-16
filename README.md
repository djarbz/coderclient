# coderclient
Coder Electron Client


## Environment Setup
1) Install [Node Version Manager](https://github.com/nvm-sh/nvm#installing-and-updating)
    1) `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash`
    2) Close and reopen the terminal or `source ~/.bashrc`.
    3) Verify installation with `command -v nvm`.
2) `nvm install node`
3) `npm install -g nativefier`
4) Install [PUP](https://github.com/EricChiang/pup)
    1) `curl -fSsL -o /tmp/pup.zip https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip`
    2) `unzip /tmp/pup.zip -d ~/.local/bin/`
    3) `rm -f /tmp/pup.zip`
5) Install ImageMagick
    1) `sudo apt update && sudo apt install -y imagemagick`
6) Install Wine
    1) `sudo apt install -y wine64`

## Compile your site
`./nativefier.sh 'YOUR APP NAME' 'https://www.example.com' <OPTIONAL NATIVEFIER ARGUMENTS>`