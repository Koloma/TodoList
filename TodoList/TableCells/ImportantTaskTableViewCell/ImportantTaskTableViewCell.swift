//
//  ImportantTaskTableViewCell.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class ImportantTaskTableViewCell: UITableViewCell {

	private let importantTaskCellModelInput: IImportantTaskCellModelInput

	@IBOutlet weak var taskTitleLabel: UILabel!
	@IBOutlet weak var completeSwitch: UISwitch!
	@IBOutlet weak var deadLineLabel: UILabel!

	static let reuseCellID = String(describing: ImportantTaskTableViewCell.self)
	static let nib = UINib(nibName: reuseCellID, bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

	init (importantTaskCellModelInput: IImportantTaskCellModelInput){
		self.importantTaskCellModelInput = importantTaskCellModelInput
		taskTitleLabel.text = importantTaskCellModelInput.title
		completeSwitch.isOn = importantTaskCellModelInput.completed

		super.init()
		backgroundColor = importantTaskCellModelInput.colorFailedDeadLine
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@IBAction func completeSwitchChange(_ sender: UISwitch) {
	}
}
