#!/bin/bash

# Configuration
SRC_DIR="src"                 # Directory containing the Typst source files
ROOT_TYPST_FILE="$SRC_DIR/main.typ"  # Path to the root Typst file
BUILD_DIR="build"             # Build directory
OUTPUT_PDF="$BUILD_DIR/main.pdf"  # Output PDF file path
COMMIT_MESSAGE="Build and update PDF"  # Commit message
VENV_DIR="venv"               # Virtual environment directory
REQUIREMENTS_FILE="requirements.txt"  # Requirements file

# Ensure the script is run from the root of the repo
if [ ! -f "$ROOT_TYPST_FILE" ]; then
    echo "Error: $ROOT_TYPST_FILE not found in the current directory."
    exit 1
fi

# Ensure the build directory exists
mkdir -p "$BUILD_DIR"

# Activate virtual environment if it exists
if [ -d "$VENV_DIR" ]; then
    echo "Activating virtual environment..."
    source "$VENV_DIR/bin/activate"
else
    echo "Warning: No virtual environment found. Proceeding without activation."
fi

# Compile the Typst file into the PDF
echo "Compiling Typst file into $OUTPUT_PDF..."
if typst compile "$ROOT_TYPST_FILE" "$OUTPUT_PDF"; then
    echo "PDF successfully generated at $OUTPUT_PDF."
else
    echo "Error during Typst compilation."
    exit 1
fi

# Update requirements.txt
if [ -d "$VENV_DIR" ]; then
    echo "Updating requirements.txt..."
    pip freeze > "$REQUIREMENTS_FILE"
fi

# Add all changes to git
echo "Adding changes to Git..."
git add -A

# Commit changes
echo "Committing changes..."
git commit -m "$COMMIT_MESSAGE"

# Push changes to GitHub
echo "Pushing changes to GitHub..."
if git push; then
    echo "Changes pushed to GitHub successfully."
else
    echo "Error pushing changes to GitHub."
    exit 1
fi
