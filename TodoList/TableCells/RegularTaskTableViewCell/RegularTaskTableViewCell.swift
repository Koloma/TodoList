//
//  RegularTaskTableViewCell.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class RegularTaskTableViewCell: UITableViewCell {

	private let regularTaskCellModel: IRegularTaskCellModelInput

	@IBOutlet private weak var taskTitleLabel: UILabel!
	@IBOutlet private weak var completeTaskSwitch: UISwitch!

	static let reuseCellID = String(describing: RegularTaskTableViewCell.self)
	static let nib = UINib(nibName: reuseCellID, bundle: nil)


	init (regularTaskCellModel: IRegularTaskCellModelInput){
		self.regularTaskCellModel = regularTaskCellModel
		taskTitleLabel.text = regularTaskCellModel.title
		completeTaskSwitch.isOn = regularTaskCellModel.completed
		super.init()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func awakeFromNib() {
        super.awakeFromNib()

    }

	@IBAction func completeSwitchChange(_ sender: UISwitch) {
	}

    
}
