# Control the verbosity
ifeq ($(V),1)
  quiet =
  Q =
else
  quiet = quiet_
  Q = @
endif

# Command echoing
cmd = @$(echo-cmd) $(cmd_$(1))
echo-cmd = $(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';)

VIM_VERSION := $(shell vim --version | head -n1 | cut -d ' ' -f 5)
VIM_REPO := https://github.com/vim/vim.git
HOME_DIR := $(HOME)
REQUIRED_VERSION := 9.1

all: check_version symlink_configs install_plugins

quiet_cmd_check_version = CHECK   Vim version
cmd_check_version = 
cmd_check_version += if [ $$(echo "$(VIM_VERSION) < $(REQUIRED_VERSION)" | bc -l) -eq 1 ]; then
cmd_check_version +=     echo "    Vim version $(VIM_VERSION) is less than required version $(REQUIRED_VERSION)";
cmd_check_version +=     $(MAKE) install_vim V=$(V);
cmd_check_version += else
cmd_check_version +=     echo "    Vim version $(VIM_VERSION) is sufficient";
cmd_check_version += fi
check_version:
	$(call cmd,check_version)

quiet_cmd_install_vim = INSTALL Vim from source
cmd_install_vim = 
cmd_install_vim += git clone $(VIM_REPO) vim_source
cmd_install_vim += && cd vim_source
cmd_install_vim += && ./configure --prefix=$(HOME_DIR)/.local
cmd_install_vim += && make
cmd_install_vim += && make install
cmd_install_vim += && cd ..
cmd_install_vim += && rm -rf vim_source
install_vim:
	$(call cmd,install_vim)

quiet_cmd_symlink_configs = LINK    Vim configuration files
cmd_symlink_configs = 
cmd_symlink_configs += ln -sf $(CURDIR)/.vim/.vimrc $(HOME_DIR)/.vimrc
cmd_symlink_configs += && rm -rf $(HOME_DIR)/.vim
cmd_symlink_configs += && ln -sfn $(CURDIR)/.vim $(HOME_DIR)/.vim
symlink_configs:
	$(call cmd,symlink_configs)

quiet_cmd_install_plugins = PLUGIN  Install Vim plugins
cmd_install_plugins = vim +'PlugInstall --sync' +qa

install_plugins:
	$(call cmd,install_plugins)

quiet_cmd_clean = CLEAN   Vim configurations
cmd_clean = 
cmd_clean += rm -f $(HOME_DIR)/.vimrc
cmd_clean += && rm -rf $(HOME_DIR)/.vim
clean:
	$(call cmd,clean)

.PHONY: all check_version install_vim symlink_configs install_plugins clean
