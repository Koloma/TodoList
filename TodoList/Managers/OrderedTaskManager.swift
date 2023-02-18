//
//  OrderedTaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

/// Менеджер задач с сортировкой
final class OrderedTaskManager: ITaskManager {
	private let taskManager: ITaskManager


	/// Инициализатор OrderedTaskManager
	/// - Parameter taskManager
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}


	/// Возвращает список всех отсортированных задач
	func allTasks() -> [ITask] {
		return sorted(tasks: taskManager.allTasks())
	}

	/// Возвращает список всех отсортированных  выполненных задач
	func completedTasks() -> [ITask] {
		return sorted(tasks: taskManager.completedTasks())
	}

	/// Возвращает список всех отсортированных невыполненных задач
	func notCompletedTasks() -> [ITask] {
		return sorted(tasks: taskManager.notCompletedTasks())
	}

	/// Добавить задачу в список задач
	func addTask(task: ITask) {
		taskManager.addTask(task: task)
	}

	/// Удалить задачу и списка задач
	func delTask(task: ITask) {
		taskManager.delTask(task: task)
	}

	private func sorted(tasks: [ITask]) -> [ITask] {
		tasks.sorted {
			if let task0: ImportantTask = $0 as? ImportantTask
				, let task1: ImportantTask = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}

			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}

			if $0 is RegularTask, $1 is ImportantTask {
				return true
			}

			return true
		}
	}
}
