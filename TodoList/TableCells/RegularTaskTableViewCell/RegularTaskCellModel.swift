//
//  RegularTaskCellModel.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

/// Протокол для модели ячейки отображающей RegularTask.
protocol IRegularTaskCellModelInput {
	/// Флаг выполнения задачи.
	var completed: Bool { get }
	/// Название задачи.
	var title: String { get }
}

/// Модель для отображения информации о RegularTask в ячейке таблицы.
struct RegularTaskCellModelInput: IRegularTaskCellModelInput {
	var completed: Bool
	var title: String

	init(task: RegularTask) {
		self.completed = task.completed
		self.title = task.title
	}
}
