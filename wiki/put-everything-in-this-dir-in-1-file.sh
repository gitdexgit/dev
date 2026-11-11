#!/bin/bash

mkdir -p ~/wiki/one_file && for f in ~/wiki/*.md; do echo -e "\n# FILE: $(basename "$f")\n---\n"; cat "$f"; echo -e "\n"; done > ~/wiki/one_file/all_notes.md
