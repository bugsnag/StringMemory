PLATFORM?=iOS
OS?=latest
PROJECT_FLAGS=-scheme Universal

PLATFORM_STR=platform=${PLATFORM}
DESTINATION_macOS=${PLATFORM_STR}
DESTINATION_tvOS=${PLATFORM_STR} Simulator,name=Apple TV,OS=$(OS)
DESTINATION_iOS=${PLATFORM_STR} Simulator,name=iPhone 6s,OS=$(OS)

DESTINATION?=${DESTINATION_${PLATFORM}}
BUILD_FLAGS=-destination "$(DESTINATION)" -configuration Debug
XCODEBUILD=xcodebuild

build:
	xcodebuild $(PROJECT_FLAGS) $(BUILD_FLAGS) build

clean:
	xcodebuild $(PROJECT_FLAGS) clean

test:
	xcodebuild $(PROJECT_FLAGS) $(BUILD_FLAGS) test
