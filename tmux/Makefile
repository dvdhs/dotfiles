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

HOME_DIR := $(HOME)
TPM_REPO := https://github.com/tmux-plugins/tpm
TPM_DIR := $(HOME_DIR)/.tmux/plugins/tpm
TMUX_REPO := https://github.com/tmux/tmux.git
REQUIRED_VERSION := 3.3

# Function to compare versions
define version_ge
$(shell printf '%s\n' $(1) $(2) | sort -V -C && echo 1 || echo 0)
endef

all: check_tmux_version install_tpm install_plugins symlink_config

quiet_cmd_check_tmux_version = CHECK   Tmux version
cmd_check_tmux_version = 
cmd_check_tmux_version += TMUX_VERSION=$$(tmux -V | cut -d ' ' -f2 | sed 's/[a-z]//g');
cmd_check_tmux_version += REQUIRED_VERSION=$(REQUIRED_VERSION);
cmd_check_tmux_version += if [ -z "$$TMUX_VERSION" ]; then
cmd_check_tmux_version +=     echo "Tmux not found. Installing...";
cmd_check_tmux_version +=     $(MAKE) install_tmux V=$(V);
cmd_check_tmux_version += elif [ $$(printf '%s\n' "$$REQUIRED_VERSION" "$$TMUX_VERSION" | sort -V | head -n1) = "$$REQUIRED_VERSION" ]; then
cmd_check_tmux_version +=     echo "Tmux version $$TMUX_VERSION is sufficient";
cmd_check_tmux_version += else
cmd_check_tmux_version +=     echo "Tmux version $$TMUX_VERSION is less than required version $$REQUIRED_VERSION";
cmd_check_tmux_version +=     $(MAKE) install_tmux V=$(V);
cmd_check_tmux_version += fi
check_tmux_version:
	$(call cmd,check_tmux_version)

quiet_cmd_install_tmux = INSTALL Tmux from source
cmd_install_tmux = 
cmd_install_tmux += git clone $(TMUX_REPO) tmux_source
cmd_install_tmux += && cd tmux_source
cmd_install_tmux += && sh autogen.sh
cmd_install_tmux += && ./configure --prefix=$(HOME_DIR)/.local
cmd_install_tmux += && make
cmd_install_tmux += && make install
cmd_install_tmux += && cd ..
cmd_install_tmux += && rm -rf tmux_source
cmd_install_tmux += && echo "export PATH=$(HOME_DIR)/.local/bin:$$PATH" >> $(HOME_DIR)/.bashrc
install_tmux:
	$(call cmd,install_tmux)

quiet_cmd_install_tpm = INSTALL Tmux Plugin Manager
cmd_install_tpm = 
cmd_install_tpm += mkdir -p $(HOME_DIR)/.tmux/plugins
cmd_install_tpm += && if [ ! -d "$(TPM_DIR)" ]; then
cmd_install_tpm +=     git clone $(TPM_REPO) $(TPM_DIR);
cmd_install_tpm += else
cmd_install_tpm +=     echo "TPM already installed. Updating...";
cmd_install_tpm +=     cd $(TPM_DIR) && git pull;
cmd_install_tpm += fi
install_tpm:
	$(call cmd,install_tpm)

quiet_cmd_install_plugins = INSTALL Tmux plugins
cmd_install_plugins = 
cmd_install_plugins += $(TPM_DIR)/scripts/install_plugins.sh
install_plugins: install_tpm
	$(call cmd,install_plugins)

quiet_cmd_symlink_config = LINK    Tmux configuration file
cmd_symlink_config = 
cmd_symlink_config += ln -sf $(CURDIR)/.tmux.conf $(HOME_DIR)/.tmux.conf
cmd_symlink_config += && rm -rf $(HOME_DIR)/.tmux 
cmd_symlink_config += && ln -sfn $(CURDIR)/.tmux $(HOME_DIR)/.tmux 
symlink_config:
	$(call cmd,symlink_config)

quiet_cmd_clean = CLEAN   Tmux configurations
cmd_clean = 
cmd_clean += rm -rf $(HOME_DIR)/.tmux
cmd_clean += && rm -f $(HOME_DIR)/.tmux.conf
cmd_clean += && rm -rf $(HOME_DIR)/.local/bin/tmux*
cmd_clean += && sed -i '/export PATH=.*\/.local\/bin/d' $(HOME_DIR)/.bashrc
clean:
	$(call cmd,clean)

.PHONY: all check_tmux_version install_tmux install_tpm install_plugins symlink_config clean
