//
//  ImportantTaskCellModel.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

/// Протокол для модели ячейки отображающей ImportantTask
protocol IImportantTaskCellModelInput {

	/// Флаг выполнения задачи
	var completed: Bool { get }
	/// Название задачи
	var title: String { get }
	/// Время окончания задачи
	var deadLine: String { get }
	/// Цвет подсветки невыполненой в срок задачи
	var colorFailedDeadLine: UIColor { get }
}

/// Модель для отображения информации о ImportantTask в ячейке таблицы
struct ImportantTaskCellModelInput: IImportantTaskCellModelInput {
	var completed: Bool
	var title: String
	var deadLine: String
	var colorFailedDeadLine: UIColor

	init(task: ImportantTask) {
		self.completed = task.completed
		self.title = "[\(task.taskPriority)] \(task.title)"

		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "E, hh:mm dd.MM.YYYY"
		self.deadLine = dateFormatter.string(from: task.deadLine)
		if (task.deadLine >= Date()) {
			self.colorFailedDeadLine = .systemBackground
		} else {
			self.colorFailedDeadLine = .systemPink
		}
	}
}

