# ==============================================================================
#  RP SWIFT GENERATION MAKEFILE
# ==============================================================================

# ---------------------------- CONFIGURATION -----------------------------------
# The path to the submodule containing .proto files and buf config
PROTO_ROOT := render-protocol-spec

# The config file specific to Swift (inside the submodule)
BUF_CONFIG := $(PROTO_ROOT)/buf.gen.swift.yaml

# The destination for generated files (Standard SPM structure)
OUTPUT_DIR := Sources/RPGeneratedSwift

# ------------------------------- TASKS ----------------------------------------

.PHONY: all generate clean update-protos

all: generate

# 1. Update the submodule to get the latest .proto definitions
update-protos:
	@echo "🔄 Updating submodule..."
	git submodule update --remote --merge

# 2. Clean the output directory to remove stale files
clean:
	@echo "🧹 Cleaning previous build..."
	rm -rf $(OUTPUT_DIR)/*

# 3. Generate the Swift code
generate: clean
	@echo "🚀 Generating Swift sources..."
	@mkdir -p $(OUTPUT_DIR)
# command breakdown:
# 1. input: $(PROTO_ROOT) -> The directory containing .proto files
# 2. --template: Uses the config file located INSIDE the submodule
# 3. -o: Overrides the output path to your local Source folder
	buf generate $(PROTO_ROOT) \
		--template $(BUF_CONFIG) \
		-o $(OUTPUT_DIR)
	@echo "✅ Swift generation complete!"