SRC_DIR = src
OUT_DIR = build
$(shell mkdir $(OUT_DIR) 2>/dev/null)

MAINFILE = resume

COMPILER = latexmk
COMPILER_FLAGS := -output-directory=$(OUT_DIR)
BIBTEX = bibtex

.PHONY: all
all: $(MAINFILE).pdf ## Compile the LaTeX project. This will build a PDF document.

$(MAINFILE).pdf:
	$(COMPILER) $(COMPILER_FLAGS) $(MAINFILE)

.PHONY: show
show: ## Open the resulting PDF
	open ./$(OUT_DIR)/$(MAINFILE).pdf

.PHONY: clean
clean: ## Remove LaTeX build files
	-rm -f *.aux
	-rm -f *.log
	-rm -f *.toc
	-rm -f *.bbl
	-rm -f *.blg
	-rm -f *.out
	-rm -f *.fls
	-rm -f *.fdb_latexmk

.PHONY: cleanall
cleanall: clean ## Remove the entire output (build) directory
	-rm -f *.pdf
	-rm -f *.ps
	-rm -f *.dvi
	-rm -rf $(OUT_DIR)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'