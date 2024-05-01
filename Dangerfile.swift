import Danger
import Foundation

let danger = Danger()
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles

if editedFiles.count - danger.git.deletedFiles.count > 300 {
  warn("Big PR, try to keep changes smaller if you can")
}

// Encourage writing up some reasoning about the PR, rather than just leaving a title.
if let body = danger.github.pullRequest.body?.lowercased() {
    let issuePattern = try! Regex("#[0-9]+")
    if !body.contains(issuePattern) {
        warn("Please add issue id.")
    }
} else {
    warn("Please add issue id.")
}

// Support running via `danger local`
if danger.github != nil {
    // These checks only happen on a PR
    if danger.github.pullRequest.title.contains("WIP") {
        warn("PR is classed as Work in Progress")
    }
}

print("Running Swiftlint on changed files...")
<<<<<<< Updated upstream
SwiftLint.lint(.files(editedFiles), inline: true, strict: true, quiet: false)
message("Done")
=======
SwiftLint.lint(.files(editedFiles), inline: true, strict: true, quiet: false, configFile)
SwiftLint.lint(.files(editedFiles), inline: true, configFile: ".swiftlint.yml", strict: true, quiet: false)
>>>>>>> Stashed changes
