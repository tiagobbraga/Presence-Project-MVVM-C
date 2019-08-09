//
//  StudentTableViewCell.swift
//  Personal
//
//  Created by Tiago Braga on 11/22/18.
//  Copyright © 2018 Physis. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    
    var presenceButtonHandler: (() -> Void)?
    
    var viewModel: StudentCellViewModel? {
        didSet {
            self.bindVM()
        }
    }
    
    private func bindVM() {
        self.nameLabel?.text = self.viewModel?.name
        self.lessonLabel?.text = self.viewModel?.detailLesson
    }

    @IBAction func onPresence(_ sender: Any) {
        self.presenceButtonHandler?()
    }
    
}
