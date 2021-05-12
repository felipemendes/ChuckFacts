import Danger 
let danger = Danger()

let prTitle = danger.github.pullRequest.title
if prTitle.contains("WIP") {
    warn("PR is classed as _Work in Progress_.")
}
