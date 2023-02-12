//
//  ImportantTaskTableViewCell.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class ImportantTaskTableViewCell: UITableViewCell {
	
	private var importantTaskCellModelInput: IImportantTaskCellModelInput? = nil
	
	@IBOutlet weak var view: UIView!
	@IBOutlet weak var taskTitleLabel: UILabel!
	@IBOutlet weak var completeSwitch: UISwitch!
	@IBOutlet weak var deadLineLabel: UILabel!
	
	static let reuseCellID = String(describing: ImportantTaskTableViewCell.self)
	static let nib = UINib(nibName: reuseCellID, bundle: nil)
	static let cellHeight = 80.0
	
	public func config (model: IImportantTaskCellModelInput){
		self.importantTaskCellModelInput = model
		taskTitleLabel.text = model.title
		completeSwitch.isOn = model.completed
		deadLineLabel.text = model.deadLine
		view.backgroundColor = model.colorFailedDeadLine
	}
	
	
	@IBAction func completeSwitchChange(_ sender: UISwitch) {
		print(sender.isOn)
	}
}
