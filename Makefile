# Variables
SCRIPT_NAME = check-cert
SCRIPT_FILE = check_cert_key_match
MAN_FILE = check-cert.1
INSTALL_DIR = /usr/local/bin
MAN_DIR = /usr/share/man/man1

# Targets
.PHONY: all install uninstall clean

all:
	@echo "Available targets: install, uninstall, clean"

install: $(SCRIPT_FILE) $(MAN_FILE)
	@echo "Installing script..."
	sudo cp $(SCRIPT_FILE) $(INSTALL_DIR)/$(SCRIPT_NAME)
	sudo chmod +x $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Installing man page..."
	gzip -f $(MAN_FILE) # force re-gzip even if exists
	sudo cp $(MAN_FILE).gz $(MAN_DIR)/$(MAN_FILE).gz
	sudo mandb
	@echo "✅ Installation completed!"

uninstall:
	@echo "Removing installed script and man page..."
	sudo rm -f $(INSTALL_DIR)/$(SCRIPT_NAME)
	sudo rm -f $(MAN_DIR)/$(MAN_FILE).gz
	sudo mandb
	@echo "✅ Uninstallation completed!"

clean:
	@echo "Cleaning generated files..."
	rm -f $(MAN_FILE).gz
