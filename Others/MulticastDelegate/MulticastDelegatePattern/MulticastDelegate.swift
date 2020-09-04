//
//  MulticastDelegate.swift
//  MulticastDelegatePattern
//
//  Created by yasinkbas on 4.09.2020.
//

import Foundation

class MulticastDelegate<T> {

    private let objects: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    func listenOn(_ delegate: T) {
        objects.add(delegate as AnyObject)
    }

    func abort(_ delegate: T) {
        for object in objects.allObjects.reversed() {
            if object === delegate as AnyObject {
                objects.remove(object)
            }
        }
    }

    func invoke(_ invocation: (T) -> Void) {
        for object in objects.allObjects.reversed() {
            invocation(object as! T)
        }
    }
}
