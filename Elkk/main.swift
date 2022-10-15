//
//  main.swift
//  Elkk
//
//  Created by Aayush Pokharel on 2022-10-15.
//

import AppKit
import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

NSApp.setActivationPolicy(.prohibited)
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
