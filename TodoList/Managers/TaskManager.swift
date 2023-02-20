//
//  TaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation


/// Менеджер по управлению списком задач.
final class TaskManager: ITaskManager {

	private var tasks:[Task] = []


	/// Инициализатор TaskManager.
	/// - Parameter список задач
	init(tasks: [Task]) {
		self.tasks = tasks
	}

	/// Возвращает список всех задач.
	/// - Returns: [Task]
	func allTasks() -> [Task] {
		return tasks
	}

	/// Возвращает список завершенных задач.
	/// - Returns: [Task]
	func completedTasks() -> [Task] {
		return tasks.filter { $0.completed }
	}

	/// Возвращает список не завершенных задач.
	/// - Returns: [Task]
	func notCompletedTasks() -> [Task] {
		return tasks.filter { !$0.completed }
	}

	/// Добавляет новую задачу к списку задач.
	/// - Parameter task: Task
	func addTask(task: Task) {
		tasks.append(task)
	}

	/// Удаляет задачу из списка задач.
	/// - Parameter task: Task
	func delTask (task: Task) {
		tasks.removeAll { $0.title == task.title }
	}
}

