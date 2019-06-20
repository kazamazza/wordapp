//
//  Events.swift
//  KliraTest
//
//  Created by Antonio Casamassa on 2019-06-19.
//  Copyright © 2019 Antonio Casamassa. All rights reserved.
//

import UIKit

class Events {
    static let center = NotificationCenter.default
    
    static func on(_ key: String, _ observer: AnyObject, _ action: Selector) {
        center.addObserver(observer, selector: action, name: NSNotification.Name(key), object: nil)
    }
    
    static func send(key: String, info: [AnyHashable : Any]?) {
        center.post(name: NSNotification.Name(key), object: nil, userInfo:info )
    }
}

