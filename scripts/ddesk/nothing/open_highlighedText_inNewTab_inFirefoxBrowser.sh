#!/bin/bash


#=== pluster fix to ripcord



selected_txt=$(xclip -o -selection clipboard | tr -d '\n')

firefox --new-window "$selected_txt"
