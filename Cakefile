
# just helper variables to use these values in a consistent way across whole file

currentSwiftVersion = "3.1.0"



# Change this to set a different Project file name
project.name = "Marvel"

# Replace this with your class prefix for Objective-C files.
# project.class_prefix = "APP"

project.organization = "TPLioy"

# By default Xcake defaults to creating the standard Debug and Release
# configurations, uncomment these lines to add your own.
#
#debug_configuration :Staging
#debug_configuration :Debug
#release_configuration :Release

# Change these to the platform you wish to support (ios, osx) and the
# version of that platform (8.0, 9.0, 10.10, 10.11)
#
application_for :ios, 10.0 do |target|

    target.language = :swift

    #Update these with the details of your app
    target.name = "Marvel"
    target.all_configurations.each { |c| c.product_bundle_identifier = "com.tpioy.marvelapp"}

    # Uncomment to target iPhone devices only
    #
    # File patterns can be seen here https://guides.cocoapods.org/syntax/podspec.html#group_file_patterns
    #
    target.all_configurations.each { |c| c.supported_devices = :iphone_only}

    # Uncomment this to include additional files
    #
    #target.include_files << "FolderToInclude/*.*"

    # Uncomment this to exclude additional files
    #
    # File patterns can be seen here https://guides.cocoapods.org/syntax/podspec.html#group_file_patterns
    #
    #target.exclude_files << "ExcludeToInclude/*.*"

    # Uncomment to set your own build settings
    #
    target.all_configurations.each do |c|
      c.settings["SWIFT_VERSION"] = currentSwiftVersion
      c.settings["INFOPLIST_FILE"] = "Marvel/Resources/Info.plist"
    end
    #target.all_configurations.each { |c| c.settings["GCC_PREFIX_HEADER"] = "APP-Prefix-Header.pch"}
    #target.all_configurations.each { |c| c.settings["SWIFT_OBJC_BRIDGING_HEADER"] = "APP-Bridging-Header.h"}

    # Uncomment to define your own preprocessor macros
    #
    #target.all_configurations.each { |c| c.preprocessor_definitions["API_ENDPOINT"] = "https://example.org".to_obj_c}

    #Configure schemes
    target.scheme(target.name) do |scheme|
      scheme.test_configuration = :debug
      scheme.launch_configuration = :debug
      scheme.archive_configuration = :release
    end

    # Configure Build phases
    target.shell_script_build_phase "[CP] Check Pods Manifest.lock", <<-SCRIPT
      diff "${PODS_ROOT}/../Podfile.lock" "${PODS_ROOT}/Manifest.lock" > /dev/null
      if [ $? != 0 ] ; then
          # print error to STDERR
          echo "error: The sandbox is not in sync with the Podfile.lock. Run 'pod install' or update your CocoaPods installation." >&2
          exit 1
      fi
    SCRIPT

    target.shell_script_build_phase "[CP] Embed Pods Frameworks", <<-SCRIPT
      "${SRCROOT}/Pods/Target Support Files/Pods-Marvel/Pods-Marvel-frameworks.sh"
    SCRIPT

    target.shell_script_build_phase "[CP] Copy Pods Resources", <<-SCRIPT
      "${SRCROOT}/Pods/Target Support Files/Pods-Marvel/Pods-Marvel-resources.sh"
    SCRIPT

    target.shell_script_build_phase "SwiftGen Images", <<-SCRIPT
      "${PODS_ROOT}/SwiftGen/bin/swiftgen" images -t swift3 "${SRCROOT}/Marvel/Resources/Assets.xcassets" --output "${SOURCE_ROOT}/Marvel/Resources/ImageAssets.swift" --enumName ImageAssets
    SCRIPT

    # Comment to remove Unit Tests for your app
    #
    unit_tests_for target do |test_target|

        test_target.name = "MarvelTests"
        test_target.include_files = ["MarvelTests/**/*.*"]

        test_target.all_configurations.each do |c|
          c.settings["SWIFT_VERSION"] = currentSwiftVersion
        end
        # configure any other target-related properties
        # as you would do with application target
    end

    # Uncomment to create a Watch App for your application.
    #
    #watch_app_for target, 2.0
end
