//
//  AppDelegate.swift
//  Elkk
//
//  Created by Aayush Pokharel on 2022-10-15.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    private var emulator: KeyEmulate = .init()

    private var playing: Bool = false
    private var skipItem: NSStatusItem!
    private var playPauseItem: NSStatusItem!
    private var backItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        skipItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        playPauseItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        backItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = backItem.button {
            button.image = NSImage(systemSymbolName: "backward.end.fill", accessibilityDescription: "play previous music")
            button.action = #selector(songBackward)
        }

        if let button = playPauseItem.button {
            button.image = NSImage(systemSymbolName: "play.fill", accessibilityDescription: "toggle playback button")
            button.action = #selector(togglePlayPause)
        }
        if let button = skipItem.button {
            button.image = NSImage(systemSymbolName: "forward.end.fill", accessibilityDescription: "play next music")
            button.action = #selector(songForward)
        }
    }

    @objc func songBackward() {
        emulator.emulate("previous")
    }

    @objc func songForward() {
        emulator.emulate("next")
    }

    @objc func togglePlayPause() {
        emulator.emulate("playpause")
        playing.toggle()
        if let button = playPauseItem.button {
            button.image = NSImage(systemSymbolName: !playing ? "play.fill" : "pause.fill", accessibilityDescription: "toggle playback button")
        }
    }
}
