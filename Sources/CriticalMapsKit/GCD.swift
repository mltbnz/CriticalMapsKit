//
//  GCD.swift
//  CriticalMaps
//
//  Created by Malte Bünz on 16.08.19.
//  Copyright © 2019 Pokus Labs. All rights reserved.
//

import Foundation

public func onMain(_ closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}
