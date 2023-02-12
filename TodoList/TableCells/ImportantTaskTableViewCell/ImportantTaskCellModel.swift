//
//  ImportantTaskCellModel.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

protocol IImportantTaskCellModelInput {
	var completed: Bool { get }
	var title: String { get }
	var deadLine: String { get }
}

struct ImportantTaskCellModel: IImportantTaskCellModelInput {
	var completed: Bool
	var title: String
	var deadLine: String

	init(task: ImportantTask) {
		self.completed = task.completed
		self.title = task.title

		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		self.deadLine = dateFormatter.string(from: task.deadLine)
	}

}

