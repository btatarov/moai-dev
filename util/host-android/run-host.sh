#!/bin/bash
pushd ant/project > /dev/null
    ant uninstall
    ant clean
    ant "-Djava.compilerargs=-Xlint:unchecked -Xlint:deprecation" release install
    adb shell am start -a android.intent.action.MAIN -n @PACKAGE@/@PACKAGE@.MoaiActivity
    adb logcat -c
    adb logcat MoaiLog:V AndroidRuntime:E *:S
popd > /dev/null
