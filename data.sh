#!/bin/bash
set -euo pipefail

# Retrieve the data and notebook from Zenodo (DOI: 10.5281/zenodo.22014653)
BASE_URL="https://zenodo.org/records/22014653/files"
DIR="data/landing"

mkdir -p "$DIR"

for FILE in journal_entries_4203.csv synthetic_data_4203.ipynb; do
    if [ ! -f "$DIR/$FILE" ]; then
        curl -fL -o "$DIR/$FILE" "$BASE_URL/$FILE"
        printf "\n Downloaded %s\n" "$FILE"
    else
        printf "%s already exists, skipping\n" "$FILE"
    fi
done