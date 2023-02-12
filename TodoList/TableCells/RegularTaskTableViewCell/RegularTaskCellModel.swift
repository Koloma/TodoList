//
//  RegularTaskCellModel.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

protocol IRegularTaskCellModelInput {
	var completed: Bool { get }
	var title: String { get }
}


struct RegularTaskCellModel: IRegularTaskCellModelInput {
	var completed: Bool
	var title: String

	init(task: ImportantTask) {
		self.completed = task.completed
		self.title = task.title
	}
}
