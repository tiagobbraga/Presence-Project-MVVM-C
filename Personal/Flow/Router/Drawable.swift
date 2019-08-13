//
//  Drawable.swift
//  Personal
//
//  Created by Tiago Braga on 8/12/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}
