FROM archlinux 
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && bsdtar -C / -xvf "$patched_glibc"
RUN pacman -Syyu --noconfirm neovim nodejs python git make gcc clang base-devel ctags
RUN curl -sLf https://spacevim.org/install.sh | bash 
RUN mkdir -p /root/.SpaceVim.d
WORKDIR /root/.SpaceVim.d
COPY .  .
RUN nvim "+call dein#install#_update([], 'update', 0)" '+qall'
