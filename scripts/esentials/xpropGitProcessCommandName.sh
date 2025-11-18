#!/bin/bash
ps -p $(xprop | awk '/_NET_WM_PID/ {print $3}') -o comm=
