#!/bin/bash

PLUGIN_NAME="trophy-weapon"

cd scripting
spcomp $PLUGIN_NAME.sp -o ../plugins/$PLUGIN_NAME.smx
