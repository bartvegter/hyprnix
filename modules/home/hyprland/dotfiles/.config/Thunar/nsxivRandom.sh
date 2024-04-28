#!/usr/bin/env sh

nsxiv -tarbs f "$(find $1 -type d | shuf | head -n 1 | sed "s/ /\\ /g" | sed "s/(/\\(/g" | sed "s/)/\\)/g")"
