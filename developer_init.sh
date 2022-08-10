#!/bin/bash


# Script can be run whenever repo is cloned from GitHub or
# whenever you want to clean up the workspace and re-generate stale files

dir="log"
if [ ! -d $dir ]; then
  mkdir -p $dir;
fi
echo "Cleaning flutter workspace.."
flutter clean > $dir/log.txt
echo "Acquiring necessary flutter pub packages from pubspec.yaml file.."
flutter pub get > $dir/log.txt
echo "Generating freezed models under sub-directories in lib/models/.."
flutter pub run build_runner build --delete-conflicting-outputs > $dir/log.txt
echo "Verbose output directed to $dir/log.txt"
exit 1