#!/bin/bash
# We use single quotes around the bash -c part to protect the {cmd} placeholder
rofi -show run -run-command "bash -c '{cmd}'"
