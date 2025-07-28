#!/bin/bash
#******************************************************************************
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#******************************************************************************/

# Stop nbdkit when x100 card is removed
# @1:  MHI Channel no
stop_nbdkit() {
    portno=$(( 10809 + $1 ))
    config_portno=$(( 12809 + $1 ))
    kill -9 `ps augx | grep "nbdkit" | grep $portno |  awk '{print $2}'`
    kill -9 `ps augx | grep "nbdkit" | grep $config_portno |  awk '{print $2}'`
}

# Udev rule triggers csm-nbdkit-stop script with mhi_CSM_CTRL channel as argument
# when Device disconnected on PCIe channel
# $1 - MHI#_CSM_CTRL
channel="$1"
echo "Device removed in $channel"
# Retrieve channel no from the /dev/mhi#_CSM_CTRL string
channelno=$(echo $channel | cut -d "_" -f1 | cut -d "i" -f2)
echo "Channel number retrieved $channelno"
stop_nbdkit $channelno
