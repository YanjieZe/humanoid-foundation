#!/bin/bash

# Check if input file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_video_file>"
    echo "Example: $0 media/video.mp4"
    exit 1
fi

INPUT_FILE="$1"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found"
    exit 1
fi

# Get filename without extension
FILENAME="${INPUT_FILE%.*}"
EXTENSION="${INPUT_FILE##*.}"

# Create compressed filename
OUTPUT_FILE="${FILENAME}_compressed.${EXTENSION}"

echo "Compressing '$INPUT_FILE' to '$OUTPUT_FILE'..."

# Compress video with good quality-to-size ratio
ffmpeg -i "$INPUT_FILE" -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "Compression completed successfully!"
    echo "Original size: $(du -h "$INPUT_FILE" | cut -f1)"
    echo "Compressed size: $(du -h "$OUTPUT_FILE" | cut -f1)"
else
    echo "Error: Compression failed"
    exit 1
fi