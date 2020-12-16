#!/bin/bash

. build/envsetup.sh

TOP=${PWD}
PATCH_DIR=$TOP

echo "TOP: $TOP"

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

function apply_patch {
    echo -e "${GREEN}Applying patch...${NOCOLOR}"
    echo -e "${LIGHTBLUE}Target repo:${NOCOLOR} $1"
    echo -e "${LIGHTBLUE}Patch file:${NOCOLOR} $2"
    echo ""

    cd $1
    git am -3 --ignore-whitespace $2
    cd $TOP
    echo ""
}

#################################################################
# CHERRYPICKS
#
# Example: ./vendor/lineage/build/tools/repopick.py [CHANGE_NUMBER]
#################################################################

## Device Tree: eleven_m8916
repopick -P device/motorola/msm8916-common -t 18_moto8916

## Bringup Hax (Disable LiveDisplay & mm-pp-daemon)
#repopick 296163

## eleven-ultralegacy-devices
repopick -P system/core 292788

## hardware/interfaces
repopick 296611

## hardware/qcom-caf/wlan
repopick 287125

## system/vold
repopick -t eleven-vold

## eleven-fde-crash-fix
repopick -t eleven-fde-crash-fix

## Snap
cd packages/apps/Snap && git pull "https://github.com/LineageOS/android_packages_apps_Snap" refs/changes/11/294911/1 && cd $TOP

#################################################################
# PATCHES
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################
