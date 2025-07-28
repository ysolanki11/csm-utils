#!/bin/bash
#******************************************************************************
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#******************************************************************************/

# Convert decimal serial number to hexadecimal with 0x prefix and lowercase letters
convert_serial_to_hex() {
    local decimal_serial=$1
    printf "0x%x\n" "$decimal_serial"
}
