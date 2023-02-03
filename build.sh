#!/bin/bash

PLUGIN_NAME="trophy-weapon"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -o ../plugins/$PLUGIN_NAME.smx
