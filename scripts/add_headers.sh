#!/bin/bash
HEADER="// Copyright (c) 2025 GasFurr
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
"

find . -name "*.zig" -type f | while read file; do
    if ! head -n 5 "$file" | grep -q "Copyright"; then
        echo "$HEADER" | cat - "$file" > temp && mv temp "$file"
        echo "Added header to $file"
    fi
done
