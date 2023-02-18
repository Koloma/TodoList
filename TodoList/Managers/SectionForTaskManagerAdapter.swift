//
//  SectionForTaskManagerAdapter.swift
//  TodoList
//
//  Created by Коломенский Александр on 15.02.2023.
//

import Foundation

/// Протокол для совместимости вывода в TableView.
protocol ISectionForTaskManagerAdapter {

	/// Получаем список заголовков секций таблицы.
	/// - Returns: [String]
	func getSectionsTitles() -> [String]

	/// Получаем список элементов секций таблицы.
	/// - Parameter sectionIndex
	/// - Returns: [ITask]
	func getSectionsItems(section sectionIndex: Int) -> [ITask]
}

/// Адаптер для протокола ITaskManager.
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager


	/// Инициализатор SectionForTaskManagerAdapter.
	/// - Parameter taskManager: менеджер задач
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	/// Возвращает  список заголовков для секций таблицы.
	func getSectionsTitles() -> [String] {
		return ["Not completed tasks", "Completed tasks"]
	}


	/// Возвращает список элементов для выбранной секции.
	/// - Parameter sectionIndex: индекс секции
	/// - Returns: список задач
	func getSectionsItems(section sectionIndex: Int) -> [ITask] {
		switch sectionIndex {
		case 0:
			return taskManager.notCompletedTasks()
		default:
			return taskManager.completedTasks()
		}
	}
}
