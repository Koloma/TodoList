//
//  RegularTaskTableViewCell.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class RegularTaskTableViewCell: UITableViewCell {

	private var regularTaskCellModel: IRegularTaskCellModelInput? = nil

	@IBOutlet private weak var taskTitleLabel: UILabel!
	@IBOutlet private weak var completeTaskSwitch: UISwitch!

	static let reuseCellID = String(describing: RegularTaskTableViewCell.self)
	static let nib = UINib(nibName: reuseCellID, bundle: nil)

	public func config(model: IRegularTaskCellModelInput) {
		self.regularTaskCellModel = model
		taskTitleLabel.text = model.title
		completeTaskSwitch.isOn = model.completed
	}

	@IBAction func completeSwitchChange(_ sender: UISwitch) {
		print(sender.isOn)
	}

    
}
