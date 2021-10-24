# Vim Config

Custom spacevim config

# Install guide
You can generate an AppImage from the [build_appimage.sh](https://github.com/FrancescoDeSimone/vim_config/blob/master/build_appimage.sh) script or you can clone [SpaceVim](https://spacevim.org/quick-start-guide/) and copy my init.toml file.
   
   A prebuild AppImage is available in [release](https://github.com/FrancescoDeSimone/vim_config/releases)


## Required for lsp 
- **clangd** <br> 
```
  yay -S vim-coc-clangd-git
```
- **rls** <br> 
```
    pacman -S rust \
    && rustup default stable \
    && rustup component add rls rust-analysis rust-src
```
- **sh** <br>
```
  npm i -g bash-language-server
```
- **JavaScript** <br>
```
  npm install -g javascript-typescript-langserver
```
- **Python** 
```
pip install --user python-language-server
```
- **CSS**
```
 npm install -g vscode-css-languageserver-bin
```



