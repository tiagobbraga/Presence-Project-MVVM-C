//
//  String+Utils.swift
//  Personal
//
//  Created by Tiago Braga on 8/13/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
