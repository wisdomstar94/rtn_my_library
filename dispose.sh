#! /bin/bash
if [ -d node_modules/rtn_my_library ]; then
  pushd node_modules/rtn_my_library
  FILE = "./android/build.gradle"
  if [ ! -e $FILE ]; then
    mv ./android/build.gradle.rtn ./android/build.gradle
  fi
  popd
fi