#! /bin/bash

FILE = "./android/build.gradle"

if [ ! -e $FILE ]; then
	mv ./android/build.gradle.rtn ./android/build.gradle
fi
