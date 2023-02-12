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


struct RegularTaskCellModelInput: IRegularTaskCellModelInput {
	var completed: Bool
	var title: String

	init(task: RegularTask) {
		self.completed = task.completed
		self.title = task.title
	}
}
