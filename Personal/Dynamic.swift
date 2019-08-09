//
//  Dynamic.swift
//  Personal
//
//  Created by Tiago Braga on 7/29/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
}
