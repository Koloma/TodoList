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
	/// - Parameter Section
	/// - Returns: [Task]
	func getTasksForSection(section: Section) -> [Task]

	func getSection(forIndex index: Int) -> Section
	func getSections() -> [Section]
}

enum Section: CaseIterable {
	case completed
	case uncompleted

	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

/// Адаптер для протокола ITaskManager.
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager

	private let sections: [Section] = [.uncompleted, .completed]

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
	func getSectionsItems(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 0:
			return taskManager.uncompletedTasks()
		default:
			return taskManager.completedTasks()
		}
	}

	func getSections() -> [Section] {
		sections
	}

	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}

	func getSection(forIndex index: Int) -> Section {
		let i = min(index, sections.count - 1)
		return sections[i]
	}

	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}

	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)? {
		for section in sections {
			let index = getTasksForSection(section: section).firstIndex{ task === $0 }
			if index != nil {
				return (section, index!)
			}
		}
		return nil
	}
}
