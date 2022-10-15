//
//  KeyEmulate.swift
//  Elkk
//
//  Created by Aayush Pokharel on 2022-10-15.
//

import AppKit
import Foundation

class KeyEmulate: NSObject {
    let mediaKeyDict = [
        //        Media Keys
        "volumeup": 0,
        "volumedown": 1,
        "playpause": 16,
        "mute": 07,
        "next": 17,
        "previous": 18
    ]

    func sendKey(keyCode: CGKeyCode) {
        let downEvent = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true)
        let upEvent = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false)

        downEvent?.post(tap: .cghidEventTap)
        upEvent?.post(tap: .cghidEventTap)
    }

    func HIDPostAuxKey(key: UInt32) {
        func doKey(down: Bool) {
            let flags = NSEvent.ModifierFlags(rawValue: down ? 0xA00 : 0xB00)
            let data1 = Int((key << 16) | (down ? 0xA00 : 0xB00))

            let ev = NSEvent.otherEvent(with: NSEvent.EventType.systemDefined,
                                        location: NSPoint(x: 0, y: 0),
                                        modifierFlags: flags,
                                        timestamp: 0,
                                        windowNumber: 0,
                                        context: nil,
                                        subtype: 8,
                                        data1: data1,
                                        data2: -1)
            let cev = ev?.cgEvent
            cev?.post(tap: CGEventTapLocation.cghidEventTap)
        }

        doKey(down: true)
        doKey(down: false)
    }

    func emulate(_ keyCode: String) {
        let isMediaKey = mediaKeyDict[keyCode] != nil

        if isMediaKey {
            HIDPostAuxKey(key: UInt32(mediaKeyDict[keyCode]!))
        } else {
            print("UNKNOWN KEY: \(keyCode)")
        }
    }
}
