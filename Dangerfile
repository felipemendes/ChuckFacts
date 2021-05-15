#  Lint added and modified files
swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files
swiftlint.lint_files inline_mode: true

# PR is a work in progress and shouldn't be merged yet
warn "PR is classed as Work in Progress" if github.pr_title.include? "WIP"

# Warn when there is a big PR
warn "Big PR, consider splitting into smaller" if git.lines_of_code > 600

# Add a CHANGELOG entry for app changes on MASTER
# hasChangelog = git.modified_files.grep(/CHANGELOG/).empty?
# warn hasChangelog
# isMaster = github.branch_for_base? "master")

# if (hasChangelog && isMaster) {
    # warn("Please add a changelog entry for your changes.")
# }

# declared_trivial = (github.pr_title + github.pr_body).include?("#trivial")
