#!/bin/bash

cd "$(dirname "$0")"

(wal -a 60 -i "$(ls |grep -E '*.png|*.jpg|*.jpeg' | shuf -n1)" &)
