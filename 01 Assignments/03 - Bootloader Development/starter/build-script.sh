#!/bin/bash

set -e

BUILD_OUTPUT_DIR="_build"
CONVERT_SCRIPT="../convert-office.sh"

# Files to convert to PDF
CONVERT_FILES=(
    # Add here
)

# Files to copy as-is
INCLUDE_FILES=(
    x86-mini.zip
    arm-mini.zip
    lemon_log.bin
    generate_log.py
)

mkdir -p "$BUILD_OUTPUT_DIR"

echo "Building documents in $(pwd)..."

# Convert specified files
for file in "${CONVERT_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  Converting $file..."
        "$CONVERT_SCRIPT" "$file" "$BUILD_OUTPUT_DIR"
    else
        echo "  Warning: $file not found, skipping..."
    fi
done

# Copy specified files
for file in "${INCLUDE_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  Copying $file..."
        cp "$file" "$BUILD_OUTPUT_DIR/"
    else
        echo "  Warning: $file not found, skipping..."
    fi
done

# Flatten
touch _build/.flatten

echo "Build completed!"