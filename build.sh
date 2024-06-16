#!/bin/bash

# SPDX-FileCopyrightText: 2024 Ferenc Nandor Janky <ferenj@effective-range.com>
# SPDX-FileCopyrightText: 2024 Attila Gombos <attila.gombos@effective-range.com>
# SPDX-License-Identifier: MIT

set -e -x
export TOKEN=$(gh auth status -t 2>&1 | grep Token: | head -n1 | awk '{print $3}') 
docker build  $(dirname $0) 