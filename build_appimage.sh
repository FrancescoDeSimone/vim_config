#!/bin/bash
set -xeu

clean_up(){
    rm -rf "$HERE"/AppDir/usr/bin
    rm -rf "$HERE"/AppDir/node
    rm -rf "$HERE"/AppDir/python
    rm -fr "$HERE"/AppDir/SpaceVim.d
    rm -fr "$HERE"/AppDir/SpaceVim
    rm -fr "$HERE"/AppDir/rust
    rm -fr "$HERE"/AppDir/usr
}

clone_spacevim(){
    git clone https://github.com/SpaceVim/SpaceVim.git AppDir/SpaceVim
    mkdir -p "$HERE"/AppDir/SpaceVim.d
    cp ./init.toml "$HERE"/AppDir/SpaceVim.d/init.toml
    cp -r ./autoload "$HERE"/AppDir/SpaceVim.d/autoload
}

install_ctags(){
    folder=$(mktemp -d)
    pushd "$folder"
    wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
    tar xf ctags-5.8.tar.gz
    ./ctags-5.8/configure --prefix="$folder"
    make 
    popd    
    cp "$folder"/ctags "$HERE"/AppDir/usr/bin
    rm -rf "$folder"
}

install_python(){
    folder=$(mktemp -d)
    git clone https://github.com/python/cpython "$folder"/cpython
    pushd "$folder"/cpython
    ./configure --prefix="$HERE"/AppDir/usr
    make install 
    popd
    rm -rf "$folder"
}

install_w3m(){
    folder=$(mktemp -d)
    git clone https://salsa.debian.org/debian/w3m "${folder}/w3m"
    pushd "${folder}/w3m"
    ./configure --prefix="$HERE"/AppDir/usr
    make install
    popd
    rm -rf "$folder"
}

install_node(){
    folder=$(mktemp -d)
    mkdir -p "${folder}/node"
    wget -O "${folder}/node/node.tar.gz" https://nodejs.org/dist/v16.10.0/node-v16.10.0.tar.gz 
    tar xfv "${folder}/node/node.tar.gz" -C "${folder}/node/"
    pushd "${folder}/node/node-v16.10.0"
    ./configure --prefix="$HERE"/AppDir/usr
    make install
    popd
    rm -rf "$folder"
}

install_w3m(){
    folder=$(mktemp -d)
    git clone https://salsa.debian.org/debian/w3m "${folder}/w3m"
    pushd "${folder}/w3m"
    ./configure --prefix="$HERE"/AppDir/usr
    make install
    popd
    rm -rf "$folder"
}

install_clangd(){
    folder=$(mktemp -d)
    pushd "$folder"
    wget -O clangd.zip https://github.com/clangd/clangd/releases/download/12.0.1/clangd-linux-12.0.1.zip
    unzip clangd.zip -d "$(pwd)"/clangd
    popd    
    cp "$folder"/clangd/clangd_12.0.1/bin/clangd "$HERE"/AppDir/usr/bin
    rm -rf "$folder"
}

install_fzf(){
    folder=$(mktemp -d)
    wget -O "$folder"/fzf.tar.gz https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz
    tar xfv "$folder"/fzf.tar.gz -C "$HERE"/AppDir/usr/bin
    rm -rf "$folder"

}

install_nvim(){
    mkdir -p "$HERE"/AppDir/usr/bin
    wget -O "$HERE"/AppDir/usr/bin/nvim \
       https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x "$HERE"/AppDir/usr/bin/nvim
}

install_python_dep(){
    mkdir -p "$HERE"/AppDir/python
    PIP_TARGET="${HERE}/AppDir/python" pip install --target="${HERE}/AppDir/python" \
        python-language-server pynvim yapf isort coverage autoflake pylint 
    cp "$HERE"/AppDir/python/bin/* "$HERE"/AppDir/usr/bin
    rm -rf "$HERE"/AppDir/python
}

install_node_dep(){
    mkdir -p "$HERE"/AppDir/node
    npm install -g --prefix "$HERE"/AppDir/node \
                        typescript-language-server \
                        javascript-typescript-langserver \
                        vscode-css-languageserver-bin \
                        bash-language-server \
                        purescript-language-server
    
    cp "$HERE"/AppDir/node/bin/* "$HERE"/AppDir/usr/bin
    rm -rf "$HERE"/AppDir/node
}

install_rust_dep(){
    mkdir "$HERE"/AppDir/rust
    RUSTUP_TOOLCHAIN="stable" \
    RUSTUP_HOME="${HERE}/AppDir/rust" \
    CARGO_HOME="${HERE}/AppDir/rust" \
    rustup component add rls rust-analysis rust-src 
    cp "$HERE"/AppDir/rust/toolchains/stable-x86_64-unknown-linux-gnu/bin/* \
       "$HERE"/AppDir/usr/bin
    rm -rf "$HERE"/AppDir/rust
}

install_glibc(){
    folder=$(mktemp -d)
    git clone git://sourceware.org/git/glibc.git "$folder"
    pushd "${folder}"
    git checkout glibc-2.32
    mkdir build
    pushd ./build
    ../configure --prefix "$(pwd)/install"
    make -j "$(nproc)"
    make install -j "$(nproc)"
    popd
    popd
    rm -rf "$folder"
}

create_appimage(){
    folder=$(mktemp -d)
    appimagetool="$folder/appimage"
    wget -O "$appimagetool" https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
    chmod +x "$appimagetool"
    $appimagetool "$HERE"/AppDir nvim.AppImage
    echo "readlink -f $(pwd)/nvim"
    rm -rf "$folder"
}

HERE="$(dirname "$(readlink -f "${0}")")"
clean_up
clone_spacevim
install_nvim
install_ctags
install_python
install_glibc
install_w3m
install_node
install_clangd
install_fzf
install_python_dep
install_node_dep
install_rust_dep
create_appimage
clean_up
