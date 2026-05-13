#!/bin/bash

SHARED_DIR="../shared"

echo "Access-Control-Allow-Origin: *"
echo "Content-Type: text/html"
echo ""

echo "<ul>"

ls -1 "$SHARED_DIR" | while read file
do
    encoded=$(printf '%s
' "$file" \
    | sed 's/ /%20/g')

    echo "
    <li>
        <a href=\"/shared/$encoded\" download>
            $file
        </a>
    </li>"
done

echo "</ul>"

