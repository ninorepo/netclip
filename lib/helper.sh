#!/bin/bash

SHARED_DIR="$abspath/www/shared"

mapfile -t files < <(
    find "$SHARED_DIR" \
    -maxdepth 1 \
    -type f \
    | sort
)

get_file()
{
    idx=$(( $1 - 1 ))
    echo "${files[$idx]}"
}

show_list()
{
    echo "===== SHARED FILES ====="

    if [ ${#files[@]} -eq 0 ]; then
        echo "Empty"
        return
    fi

    for i in "${!files[@]}"
    do
        echo "$((i+1)) $(basename "${files[$i]}")"
    done
}

case "$1" in

    list)

        show_list

    ;;

    delete)

        shift

        if [ $# -eq 0 ]; then
            echo "Usage:"
            echo "$0 delete 1 2 3"
            exit 1
        fi

        for n in "$@"
        do
            file=$(get_file "$n")

            if [ -f "$file" ]; then

                echo "Deleting:"
                echo "$(basename "$file")"

                rm -f "$file"

            else

                echo "Invalid number:"
                echo "$n"

            fi
        done

    ;;

    share)

        SRC="$2"

        if [ -z "$SRC" ]; then

            echo "Usage:"
            echo "$0 share /path/to/file"

            exit 1
        fi

        if [ ! -f "$SRC" ]; then

            echo "File not found"

            exit 1
        fi

        base=$(basename "$SRC")

        cp "$SRC" "$SHARED_DIR/$base"

        echo "Shared:"
        echo "$base"

    ;;

    drop)

        shift

        if [ $# -eq 0 ]; then

            echo "Usage:"
            echo "$0 drop 1"
            echo "$0 drop 1 3 5"

            exit 1
        fi

        for n in "$@"
        do
            file=$(get_file "$n")

            if [ -f "$file" ]; then

                base=$(basename "$file")

                cp "$file" "./$base"

                echo "Dropped:"
                echo "$base"

            else

                echo "Invalid number:"
                echo "$n"

            fi
        done

    ;;

    clear)

        rm -f "$SHARED_DIR"/*

        echo "Shared folder cleared"

    ;;

    *)

        echo "Usage:"
        echo ""
        echo "$0 list"
        echo "$0 delete 1"
        echo "$0 delete 1 3 5"
        echo "$0 share /path/to/file"
        echo "$0 drop 2"
        echo "$0 drop 1 4 7"
        echo "$0 clear"

    ;;

esac

