import Danger
let danger = Danger()

// Add a CHANGELOG entry for app changes
let hasChangelog = danger.git.modifiedFiles.contains("changelog.md")
let isTrivial = (danger.github.pullRequest.body + danger.github.pullRequest.title).contains("#trivial")

if (!hasChangelog && !isTrivial) {
    warn("🙏 Please add a changelog entry for your changes.")
}

// Encourage smaller PRs
var bigPRThreshold = 600;
if (danger.github.pullRequest.additions + danger.github.pullRequest.deletions > bigPRThreshold) {
  warn("🚨 Pull Request size seems relatively large. If this Pull Request contains multiple changes, please split each into separate PR will helps faster, easier review.");
}

// Files changed and created should includes unit tests
let modified = danger.git.modifiedFiles
let editedFiles = modified + danger.git.createdFiles
let testFiles = editedFiles.filter { ($0.contains("Tests") || $0.contains("Test")) && ($0.fileType == .swift  || $0.fileType == .m) }
if testFiles.isEmpty {
    warn("📱 PR does not contain any files related to unit tests (ignore if your changes do not require tests)")
}

message("🎉  The PR added \(additions) and removed \(deletions) lines. 🗂 \(changedFiles) files changed.")