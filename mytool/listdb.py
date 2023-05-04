#!/usr/bin/python3
# This script list all object files in object database
import os

CACHE_DIR = os.path.join(os.getcwd(), '.dircache/objects')

for d in os.listdir(CACHE_DIR):
    sub_dir = os.path.join(CACHE_DIR, d)
    for f in os.listdir(sub_dir):
        print(os.path.join(sub_dir, f))

