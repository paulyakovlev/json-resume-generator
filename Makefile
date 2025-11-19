# Configuration
JSON_FILE = data.json
OUTPUT_DIR = build
OUTPUT_HTML = $(OUTPUT_DIR)/resume.html
OUTPUT_PDF = $(OUTPUT_DIR)/resume.pdf
CSS_FILE = styles/resume.css

# Default target
all: $(OUTPUT_PDF) $(OUTPUT_HTML)

# Generate HTML from JSON
$(OUTPUT_HTML): $(JSON_FILE) scripts/generate_resume.py $(CSS_FILE)
	@mkdir -p $(OUTPUT_DIR)
	@echo "Generating HTML from JSON..."
	@python3 ./scripts/generate_resume.py $(JSON_FILE) $(CSS_FILE) $(OUTPUT_HTML)

# Generate PDF from HTML using gooogle chrome headless agent
$(OUTPUT_PDF): $(OUTPUT_HTML)
	@echo "Generating PDF..."
	@if command -v /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome >/dev/null 2>&1; then \
		/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless --disable-gpu \
		--no-pdf-header-footer --print-to-pdf=$(OUTPUT_PDF) "file://$(shell pwd)/$(OUTPUT_HTML)"; \
	elif command -v google-chrome >/dev/null 2>&1; then \
		google-chrome --headless --disable-gpu --no-pdf-header-footer \
		--print-to-pdf=$(OUTPUT_PDF) "file://$(shell pwd)/$(OUTPUT_HTML)"; \
	elif command -v chromium >/dev/null 2>&1; then \
		chromium --headless --disable-gpu --no-pdf-header-footer \
		--print-to-pdf=$(OUTPUT_PDF) "file://$(shell pwd)/$(OUTPUT_HTML)"; \
	elif command -v wkhtmltopdf >/dev/null 2>&1; then \
		wkhtmltopdf --no-header-line --no-footer-line --no-outline \
		--margin-top 0.5in --margin-right 0.75in --margin-bottom 0.5in --margin-left 0.75in \
		$(OUTPUT_HTML) $(OUTPUT_PDF); \
	else \
		echo "No suitable PDF generator found. Please open the HTML file in Chrome and print to PDF with these settings:"; \
		echo "  - Destination: Save as PDF"; \
		echo "  - Pages: All"; \
		echo "  - More Settings → Headers and footers: UNCHECK"; \
		echo "  - More Settings → Margins: Minimum"; \
		echo "HTML file location: $(shell pwd)/$(OUTPUT_HTML)"; \
	fi
	@[ -f $(OUTPUT_PDF) ] && echo "Resume generated: $(OUTPUT_PDF)" || echo "Please generate PDF manually"

# Generate anonymized resume
ANON_JSON = data-anon.json
ANON_HTML = $(OUTPUT_DIR)/resume-anon.html
ANON_PDF = $(OUTPUT_DIR)/resume-anon.pdf

anon: $(ANON_PDF)

$(ANON_HTML): $(ANON_JSON) scripts/generate_resume.py $(CSS_FILE)
	@mkdir -p $(OUTPUT_DIR)
	@echo "Generating anonymized HTML from JSON..."
	@python3 ./scripts/generate_resume.py $(ANON_JSON) $(CSS_FILE) $(ANON_HTML)

$(ANON_PDF): $(ANON_HTML)
	@echo "Generating anonymized PDF..."
	@if command -v /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome >/dev/null 2>&1; then \
		/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless --disable-gpu \
		--no-pdf-header-footer --print-to-pdf=$(ANON_PDF) "file://$(shell pwd)/$(ANON_HTML)"; \
	elif command -v google-chrome >/dev/null 2>&1; then \
		google-chrome --headless --disable-gpu --no-pdf-header-footer \
		--print-to-pdf=$(ANON_PDF) "file://$(shell pwd)/$(ANON_HTML)"; \
	elif command -v chromium >/dev/null 2>&1; then \
		chromium --headless --disable-gpu --no-pdf-header-footer \
		--print-to-pdf=$(ANON_PDF) "file://$(shell pwd)/$(ANON_HTML)"; \
	elif command -v wkhtmltopdf >/dev/null 2>&1; then \
		wkhtmltopdf --no-header-line --no-footer-line --no-outline \
		--margin-top 0.5in --margin-right 0.75in --margin-bottom 0.5in --margin-left 0.75in \
		$(ANON_HTML) $(ANON_PDF); \
	else \
		echo "No suitable PDF generator found."; \
	fi
	@[ -f $(ANON_PDF) ] && echo "Anonymized resume generated: $(ANON_PDF)" || echo "Please generate PDF manually"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(OUTPUT_DIR)

# Help target
help:
	@echo "Resume Generator Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  all     - Generate PDF and HTML resume (default)"
	@echo "  clean   - Remove all generated files"
	@echo "  help    - Show this help message"
	@echo ""
	@echo "Files:"
	@echo "  data.json           - Resume content in JSON format"
	@echo "  styles/resume.css   - CSS styling for the resume"
	@echo "  scripts/generate_resume.py - Generates HTML from JSON"

.PHONY: all clean help
