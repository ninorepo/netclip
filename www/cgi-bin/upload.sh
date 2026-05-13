#!/bin/bash

SHARED_DIR="../shared"

echo "Access-Control-Allow-Origin: *"
echo "Content-Type: text/plain"
echo ""

raw_filename="${QUERY_STRING#filename=}"

filename=$(printf '%b' \
"${raw_filename//%/\x}")

filename="${filename//+/ }"

filename=$(basename "$filename")


if [ -z "$filename" ]; then
    echo "No filename"
    exit 1
fi

cat > "$SHARED_DIR/$filename"

echo "Upload success"

