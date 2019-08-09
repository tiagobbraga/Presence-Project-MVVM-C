//
//  Localizable.swift
//  CarroAluguel
//
//  Created by Tiago Braga on 4/22/16.
//  Copyright © 2016 Tiago Braga. All rights reserved.
//

import Foundation

struct Localizable {
    static func string(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
