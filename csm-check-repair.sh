#!/bin/bash
#******************************************************************************
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#******************************************************************************/
check-repair() {
     local PATH="$1"
     ext4_images=(cache.img.raw persist.img.raw system.img.raw userdata.img.raw systemrw.img.raw)
     for img in ${ext4_images[@]}; do
	 echo "checking for image : $PATH/$img"
         /usr/sbin/e2fsck -n $PATH/$img
         status=$?
         if [[ $status != 0 ]]; then
             /usr/sbin/e2fsck -pf $PATH/$img
             status=$?
             if [[ $status -lt 3 ]]; then
                     echo "$PATH/$img checked and repaired as needed..."
             elif [[ $status -eq 4 || $status -eq 8 ]]; then
                     echo "$PATH/$img could not be repaired, copying from flatimg..."
                     LASSEN_RAW_IMG_FOLDER=/lib/firmware/qcom/qdu100/flatimg/
                     /usr/bin/rsync -av $LASSEN_RAW_IMG_FOLDER/$img $PATH/
             fi
         fi
     done
}

