//
//  StudentViewModel.swift
//  Personal
//
//  Created by Tiago Braga on 8/7/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

protocol StudentViewModel {
    
    var updatedStudent: ((Student?) -> Void) { get set }
    var goBack: (() -> Void)? { get set }
    
    var title: String { get }
    var firstname: String? { get set }
    var lastname: String? { get set }
    var days: IndexSet? { get set }
    var hour: Dynamic<String> { get set }
    var date: Date? { get set }
    var validInputData: Dynamic<Bool> { get }
    var editableContent: Bool { get }
    var hideContainerHour: Dynamic<Bool> { get }
    
    func submitStudent()
    func desactiveStudent()
    
}
