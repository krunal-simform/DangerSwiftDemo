import Danger
import Foundation
import DangerSwiftPeriphery

let danger = Danger()
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles.filter { !$0.hasPrefix("Danger/") }

var isDangerLocal: Bool {
    CommandLine.arguments.count > 2 && CommandLine.arguments[2].hasSuffix("danger-local.js")
}

let github: GitHub! = danger.github

if !isDangerLocal {
    gitHubValidator()
}

func gitHubValidator() {
    guard github != nil else {
        fail("Configuration error: 'Danger' is not set up properly. Please check the configuration at Dangerfile.swift:23 and ensure it fulfil all the dependencies.")
        exit(0)
    }
//    validateWorkInProgressPR()
//    validatePRTitle()
//    validatePRLabels()
//    validatePRDescription()
}



func validateWorkInProgressPR() {
    // check for PR Title
    let title = github.pullRequest.title.lowercased()
    let wipKeywords = ["\\[wip\\]", "\\[do not merge\\]"]

    if title.contains(regex: "(?i)\(wipKeywords.joined(separator: "|"))") {
        fail("Warning: The Pull Request is marked as 'Work in Progress'. ")
        exit(0)
    }
}

func validatePRTitle() {
    // [#1234] ABCDEFG
    let title = github.pullRequest.title
    if !title.contains(regex: "\\[#\\d+\\] \\S+") {
        fail("Error: The pull request title must include an issue ID. Format should be `[#issue-id] Title`. Please update the title to follow this format.")
        exit(0)
    }
}

func validatePRLabels() {
    if github.issue.labels.isEmpty {
        fail("Error: The pull request must include at least one label, such as 'bug', 'enhancement', or 'feature'. Please add the appropriate label.")
        exit(0)
    }
}

func validatePRDescription() {
    let body = github.pullRequest.body?.lowercased() ?? ""
    if !body.contains(regex: "intreecom/\\S+#\\d+") {
        fail("Error: The pull request must reference an issue ID, such as 'Intreecom/Intree-Organisation#2799'. Please ensure the issue ID is included.")
        exit(0)
    }
}

DangerPeriphery.scan(peripheryExecutable: "swift run --package-path Danger periphery",
                     arguments: {
    PeripheryScanOptions.targets(["DangerSwiftDemo"])
    PeripheryScanOptions.project("DangerSwiftDemo.xcodeproj")
    PeripheryScanOptions.schemes(["DangerSwiftDemo"])
//    PeripheryScanOptions.skipBuild
}, verbose: true)

//SwiftLint.lint(.files(editedFiles), inline: true, configFile: ".swiftlint.yml", strict: true, quiet: false)

fileprivate extension String {
    func contains(regex: String) -> Bool {
        guard let regex = try? Regex(regex) else {
            return false
        }
        return !self.matches(of: regex).isEmpty
    }
}
