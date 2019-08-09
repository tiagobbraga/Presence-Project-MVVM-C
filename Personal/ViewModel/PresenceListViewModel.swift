//
//  PresenceListViewModel.swift
//  Personal
//
//  Created by Tiago Braga on 7/30/19.
//  Copyright © 2019 Physis. All rights reserved.
//

import Foundation

class PresenceListViewModel {
    
    var reloadTableViewClosure: () -> () = {  }
    var didTappedEditStudent: (StudentViewModel) -> () = { _ in }
    
    var textEditUser: String = Localizable.string(forKey: "btn_add_edit_user")
    var titlePage: Dynamic<String> = Dynamic("")
    
    var numberOfGroups: Int {
        get {
            return self.group.count
        }
    }
    
    var goBack: (() -> Void) = { }
    
    internal var student: Student! {
        didSet {
            self.titlePage.value = self.student.first_name + " " + self.student.last_name
        }
    }
    
    private var group: [[Presence]] = []
    
    init(student: Student) {
        self.student = student
        self.titlePage.value = self.student.first_name + " " + self.student.last_name
    }
    
    // MARK: Methods
    func filterData() {
        self.group = []

        let presences = Set(Array(self.student.presences)).sorted { $0.date.compare($1.date) == ComparisonResult.orderedDescending }
        var newGroup: [Presence] = []
        for (index, presence) in presences.enumerated() {
            var lastPresence: Presence? = nil
            
            if index > 0 {
                lastPresence = presences[index - 1]
            }
            
            if lastPresence != nil && presence.date.hasSame(.year, .month, as: lastPresence!.date) {
                newGroup.append(presence)
            } else {
                if newGroup.count > 0 {
                    self.group.append(newGroup)
                }
                newGroup = []
                newGroup.append(presence)
            }
        }
        self.group.append(newGroup)

        self.reloadTableViewClosure()
    }
    
    func numberOfRowsInGroup(index: Int) -> Int {
        return self.group[index].count
    }
    
    func getModel(index: Int, row: Int) -> Presence {
        return self.group[index][row]
    }
    
    func titleForSection(index: Int) -> String {
        guard let presence = self.group[index].first else { return "" }
        return "\(presence.formatMonthYear())"
    }

    
}
