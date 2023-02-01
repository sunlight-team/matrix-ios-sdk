#!/bin/sh

set -e
set -x

pod install

# archive the framework for iOS, macOS, Catalyst and the Simulator
xcodebuild archive -workspace MatrixSDK.xcworkspace -scheme MatrixSDK-iOS -destination "generic/platform=iOS" -archivePath build/MatrixSDK-iOS SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES IPHONEOS_DEPLOYMENT_TARGET=13.0 GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS=NO MARKETING_VERSION=$2 CURRENT_PROJECT_VERSION=$3
xcodebuild archive -workspace MatrixSDK.xcworkspace -scheme MatrixSDK-iOS -destination "generic/platform=iOS Simulator" -archivePath build/MatrixSDK-iOSSimulator SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES IPHONEOS_DEPLOYMENT_TARGET=13.0 GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS=NO MARKETING_VERSION=$2 CURRENT_PROJECT_VERSION=$3

cd build

# clean xcframework artifacts
if [ -d 'MatrixSDK.xcframework' ]; then rm -rf MatrixSDK.xcframework; fi
if [ -f 'MatrixSDK.xcframework.zip' ]; then rm -rf MatrixSDK.xcframework.zip; fi

# build the xcframework
xcodebuild -create-xcframework \
    -framework MatrixSDK-iOS.xcarchive/Products/Library/Frameworks/MatrixSDK.framework \
    -framework MatrixSDK-iOSSimulator.xcarchive/Products/Library/Frameworks/MatrixSDK.framework \
    -output MatrixSDK.xcframework
