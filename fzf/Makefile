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
FZF_REPO := https://github.com/junegunn/fzf.git
FZF_DIR := $(HOME_DIR)/.fzf
REQUIRED_VERSION := 0.30.0

all: check_fzf_version install_fzf setup_fzf

quiet_cmd_check_fzf_version = CHECK   FZF version
cmd_check_fzf_version = 
cmd_check_fzf_version += if command -v fzf >/dev/null 2>&1; then
cmd_check_fzf_version +=     FZF_VERSION=$$(fzf --version | cut -d ' ' -f1);
cmd_check_fzf_version +=     REQUIRED_VERSION=$(REQUIRED_VERSION);
cmd_check_fzf_version +=     if [ $$(printf '%s\n' "$$REQUIRED_VERSION" "$$FZF_VERSION" | sort -V | head -n1) = "$$REQUIRED_VERSION" ]; then
cmd_check_fzf_version +=         echo "FZF version $$FZF_VERSION is sufficient";
cmd_check_fzf_version +=     else
cmd_check_fzf_version +=         echo "FZF version $$FZF_VERSION is less than required version $$REQUIRED_VERSION";
cmd_check_fzf_version +=         $(MAKE) install_fzf V=$(V);
cmd_check_fzf_version +=     fi;
cmd_check_fzf_version += else
cmd_check_fzf_version +=     echo "FZF not found. Installing...";
cmd_check_fzf_version +=     $(MAKE) install_fzf V=$(V);
cmd_check_fzf_version += fi
check_fzf_version:
	$(call cmd,check_fzf_version)

quiet_cmd_install_fzf = INSTALL FZF
cmd_install_fzf = 
cmd_install_fzf += if [ ! -d "$(FZF_DIR)" ]; then
cmd_install_fzf +=     git clone --depth 1 $(FZF_REPO) $(FZF_DIR);
cmd_install_fzf += else
cmd_install_fzf +=     cd $(FZF_DIR) && git pull;
cmd_install_fzf += fi
cmd_install_fzf += && $(FZF_DIR)/install --all --no-bash --no-fish
install_fzf:
	$(call cmd,install_fzf)

quiet_cmd_setup_fzf = SETUP   FZF configuration
cmd_setup_fzf = 
cmd_setup_fzf += if [ -f "$(CURDIR)/.fzf.bash" ]; then
cmd_setup_fzf +=     ln -sf $(CURDIR)/.fzf.bash $(HOME_DIR)/.fzf.bash;
cmd_setup_fzf += fi
cmd_setup_fzf += && if [ -f "$(CURDIR)/.fzf.zsh" ]; then
cmd_setup_fzf +=     ln -sf $(CURDIR)/.fzf.zsh $(HOME_DIR)/.fzf.zsh;
cmd_setup_fzf += fi
cmd_setup_fzf += && if ! grep -q "source ~/.fzf.bash" $(HOME_DIR)/.bashrc; then
cmd_setup_fzf +=     echo "[ -f ~/.fzf.bash ] && source ~/.fzf.bash" >> $(HOME_DIR)/.bashrc;
cmd_setup_fzf += fi
cmd_setup_fzf += && if [ -f "$(HOME_DIR)/.zshrc" ] && ! grep -q "source ~/.fzf.zsh" $(HOME_DIR)/.zshrc; then
cmd_setup_fzf +=     echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> $(HOME_DIR)/.zshrc;
cmd_setup_fzf += fi
setup_fzf:
	$(call cmd,setup_fzf)

quiet_cmd_clean = CLEAN   Local repository
cmd_clean = 
cmd_clean += : # No-op for now, as we don't create any temporary files in the repo
clean:
	$(call cmd,clean)

quiet_cmd_uninstall = UNINSTALL FZF
cmd_uninstall = 
cmd_uninstall += rm -rf $(FZF_DIR)
cmd_uninstall += && rm -f $(HOME_DIR)/.fzf.bash $(HOME_DIR)/.fzf.zsh
cmd_uninstall += && sed -i '/source ~\/.fzf.bash/d' $(HOME_DIR)/.bashrc
cmd_uninstall += && if [ -f "$(HOME_DIR)/.zshrc" ]; then sed -i '/source ~\/.fzf.zsh/d' $(HOME_DIR)/.zshrc; fi
uninstall:
	$(call cmd,uninstall)

.PHONY: all check_fzf_version install_fzf setup_fzf clean uninstall
