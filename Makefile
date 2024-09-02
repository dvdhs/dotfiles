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

# List all subdirectories
SUBDIRS := $(wildcard */)

# Default target
all: $(SUBDIRS)

# Rule for each subdirectory
quiet_cmd_make_subdir = DESCEND $@
      cmd_make_subdir = $(MAKE) -C $@ V=$(V)
$(SUBDIRS):
	$(call cmd,make_subdir)

# Clean target
quiet_cmd_clean_subdir = CLEAN   $@
      cmd_clean_subdir = $(MAKE) -C $@ clean V=$(V)
clean:
	$(foreach dir,$(SUBDIRS),$(call cmd,clean_subdir))

.PHONY: all $(SUBDIRS) clean
