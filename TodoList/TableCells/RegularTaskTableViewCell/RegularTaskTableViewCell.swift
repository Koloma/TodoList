//
//  RegularTaskTableViewCell.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class RegularTaskTableViewCell: UITableViewCell {

	private var regularTaskCellModel: IRegularTaskCellModelInput? = nil
	private var output: ((_ value: Bool) -> Void)?

	@IBOutlet private weak var taskTitleLabel: UILabel!
	@IBOutlet private weak var completeTaskSwitch: UISwitch!
	@IBOutlet weak var view: UIView!

	static let reuseCellID = String(describing: RegularTaskTableViewCell.self)
	static let nib = UINib(nibName: reuseCellID, bundle: nil)
	static let cellHeight = 50.0

	public func config(model: IRegularTaskCellModelInput, modelOutput:@escaping ((_ value: Bool)->Void)) {
		self.regularTaskCellModel = model
		taskTitleLabel.text = model.title
		completeTaskSwitch.isOn = model.completed

		output = modelOutput
	}


	@IBAction func completeSwitchChange(_ sender: UISwitch) {
		output?(sender.isOn)
	}

}
