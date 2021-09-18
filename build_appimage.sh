#!/bin/bash
set -xeu

clean_up(){
    rm -rf ./AppDir/usr/bin
    rm -rf ./AppDir/node
    rm -rf ./AppDir/python
    rm -fr ./AppDir/SpaceVim.d
    rm -fr ./AppDir/SpaceVim
    rm -fr ./AppDir/rust
}

clone_spacevim(){
    git clone https://github.com/SpaceVim/SpaceVim.git AppDir/SpaceVim
    mkdir -p ./AppDir/SpaceVim.d
    cp ./init.toml ./AppDir/SpaceVim.d/init.toml
    cp -r ./autoload ./AppDir/SpaceVim.d/autoload
}

install_ctags(){
    folder=$(mktemp -d)
    pushd "$folder"
    wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
    tar xf ctags-5.8.tar.gz
    ./ctags-5.8/configure --prefix="$folder"
    make 
    popd    
    cp "$folder"/ctags ./AppDir/usr/bin
    rm -rf "$folder"
}

copy_binary(){
    mkdir -p ./AppDir/usr/bin
    wget -O ./AppDir/usr/bin/nvim \
       https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x ./AppDir/usr/bin/nvim
    install_ctags

    find ./AppDir/usr -type f -exec cp "{}" ./AppDir/usr/bin \;
}

install_python_dep(){
    mkdir -p ./AppDir/python
    PIP_TARGET="./AppDir/python" pip install --target="./AppDir/python" \
        python-language-server yapf isort coverage autoflake pylint 
    cp ./AppDir/python/bin/* ./AppDir/usr/bin
    rm -rf ./AppDir/python
}

install_node_dep(){
    mkdir -p ./AppDir/node
    npm install -g --prefix ./AppDir/node \
                        javascript-typescript-langserver \
                        vscode-css-languageserver-bin \
                        bash-language-server \
                        purescript-language-server
    
    cp ./AppDir/node/bin/* ./AppDir/usr/bin
    rm -rf ./AppDir/node
}

install_rust_dep(){
    mkdir ./AppDir/rust
    RUSTUP_TOOLCHAIN="stable" \
    RUSTUP_HOME="./AppDir/rust" \
    CARGO_HOME="./AppDir/rust" \
    rustup component add rls rust-analysis rust-src 
    cp ./AppDir/rust/toolchains/stable-x86_64-unknown-linux-gnu/bin/* \
       ./AppDir/usr/bin
    rm -rf ./AppDir/rust
}

create_appimage(){
    folder=$(mktemp -d)
    appimagetool="$folder/appimage"
    wget -O "$appimagetool" https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
    chmod +x $appimagetool
    $appimagetool ./AppDir
    rm -rf "$folder"
}


clean_up
clone_spacevim
copy_binary
install_python_dep
install_node_dep
install_rust_dep
create_appimage
clean_up
