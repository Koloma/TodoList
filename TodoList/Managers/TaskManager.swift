//
//  TaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation


/// Менеджер по управлению списком задач
final class TaskManager: ITaskManager {

	private var tasks:[ITask] = []


	/// Инициализатор TaskManager
	/// - Parameter список задач
	init(tasks: [ITask]) {
		self.tasks = tasks
	}

	/// Возвращает список всех задач
	/// - Returns: [ITask]
	func allTasks() -> [ITask] {
		return tasks
	}

	/// Возвращает список завершенных задач
	/// - Returns: [ITask]
	func completedTasks() -> [ITask] {
		return tasks.filter { $0.completed }
	}

	/// Возвращает список не завершенных задач
	/// - Returns: [ITask]
	func notCompletedTasks() -> [ITask] {
		return tasks.filter { !$0.completed }
	}

	/// Добавляет новую задачу к списку задач
	/// - Parameter task: ITask
	func addTask(task: ITask) {
		tasks.append(task)
	}

	/// Удаляет задачу из списка задач
	/// - Parameter task: ITask
	func delTask (task: ITask) {
		tasks.removeAll { $0.title == task.title }
	}
}

