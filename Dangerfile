# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

message("Test Comment on PR")
# Don't let testing shortcuts get into master by accident
# fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
# fail("fit left in tests") if `grep -r fit specs/ `.length > 1

# Slater config
slather.configure("Marvel.xcodeproj", "Marvel", options: {
  workspace: 'Marvel.xcworkspace',
  output_directory: "coverage",
  ignore_list: [
    "**/Storyboard.swift",
    "**/MarvelAPI.swift",
    "**/MarvelAPIManager.swift"
  ],
  ci_service: :travis,
  coverage_service: :terminal,
})

slather.notify_if_coverage_is_less_than(minimum_coverage: 80)
slather.notify_if_modified_file_is_less_than(minimum_coverage: 60)
slather.show_coverage
