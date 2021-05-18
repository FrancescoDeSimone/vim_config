FROM archlinux
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && bsdtar -C / -xvf "$patched_glibc"
RUN pacman -Syyu --noconfirm  expect unzip wget neovim rustup nodejs npm python python2 python-pip python2-pip git make gcc clang base-devel ctags fontconfig xorg-mkfontdir xorg-mkfontscale
RUN pip install --user pylint yapf isort autoflake coverage neovim jedi pipsi install python-language-server
RUN pip2 install --user pylint yapf isort autoflake coverage neovim jedi pipsi install python-language-server
RUN npm install -g vscode-css-languageserver-bin eslint-cli js-beautify bash-language-server javascript-typescript-langserver
RUN rustup default stable && rustup update && rustup component add rls rust-analysis rust-src && rustup component add rustfmt
RUN wget https://github.com/clangd/clangd/releases/download/12.0.0/clangd-linux-12.0.0.zip && unzip clangd-linux-12.0.0.zip && cp -r clangd_12.0.0/bin/* /usr/bin && cp -r clangd_12.0.0/lib/* /usr/lib
RUN curl -sLf https://spacevim.org/install.sh | bash
RUN mkdir -p /root/.SpaceVim.d
WORKDIR /root/.SpaceVim.d
COPY .  .
RUN nvim --headless "+call dein#install#_update([], 'install', 0)" '+qall'
RUN cd ~/.SpaceVim/bundle/vimproc.vim && make
RUN nvim --headless +UpdateRemotePlugins +qall
RUN ./script.sh
RUN nvim --headless "+call dein#install#_update([], 'install', 0)" '+qall'
RUN pacman -Scc --noconfirm
RUN mkdir -p /workspace
WORKDIR /workspace
