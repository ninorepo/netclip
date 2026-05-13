#!/bin/bash

current_path=$(pwd)
sed -i "s|#ABSPATH_PLACEHOLDER_HERE|export abspath=\"$current_path\"|" netclip.sh
