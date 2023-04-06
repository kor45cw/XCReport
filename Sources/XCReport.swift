// The Swift Programming Language
// https://docs.swift.org/swift-book


import ArgumentParser


@main
struct XCReport: ParsableCommand {
    static let configuration = CommandConfiguration(
            commandName: "xcreport",
            abstract: "A Swift command-line tool to manage .xcresult file",
            subcommands: [Parse.self])
}
