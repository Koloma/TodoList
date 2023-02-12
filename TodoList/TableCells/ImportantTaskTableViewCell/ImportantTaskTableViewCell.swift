//
//  ImportantTaskTableViewCell.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class ImportantTaskTableViewCell: UITableViewCell {

	private var importantTaskCellModelInput: IImportantTaskCellModelInput? = nil

	@IBOutlet weak var taskTitleLabel: UILabel!
	@IBOutlet weak var completeSwitch: UISwitch!
	@IBOutlet weak var deadLineLabel: UILabel!

	static let reuseCellID = String(describing: ImportantTaskTableViewCell.self)
	static let nib = UINib(nibName: reuseCellID, bundle: nil)
	static let cellHight = 90.0

	public func config (model: IImportantTaskCellModelInput){
		self.importantTaskCellModelInput = model
		taskTitleLabel.text = model.title
		completeSwitch.isOn = model.completed
		deadLineLabel.text = model.deadLine
		backgroundColor = model.colorFailedDeadLine
	}


	@IBAction func completeSwitchChange(_ sender: UISwitch) {
		print(sender.isOn)
	}
}
