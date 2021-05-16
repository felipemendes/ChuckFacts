# Lint on added and modified files
swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files
swiftlint.lint_files inline_mode: true

# Warn for PR classed as Work in Progress
warn "PR is a Work In Progress and shouldn't be merged yet" if github.pr_title.include? "WIP"

# Warn when there is a big PR
warn "Big PR, consider splitting into smaller" if git.lines_of_code > 600

# Warn to add a CHANGELOG entry for app changes on MAIN
changelogIsEmpty = git.modified_files.grep(/CHANGELOG/).empty?
baseBranchIsMaster = github.branch_for_base == "main"

if changelogIsEmpty && baseBranchIsMaster
    warn "Add a changelog entry for your changes."
end

# Warn to add tests if project changes is more than 40 lines of code
swiftFilesHasChanges = git.modified_files.include? "*.swift" # true
testFilesHasChanges = git.modified_files.include? "*Tests.swift" # false

if swiftFilesHasChanges && !testFilesHasChanges && git.lines_of_code > 40
    warn "You forgot to add tests for these changes"
end
