//
//  TaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

/// Менеджер по управлению списком задач.
final class TaskManager: ITaskManager {

	private var taskList: [Task] = []

	init() {}

	/// Инициализатор TaskManager.
	/// - Parameter список задач
	convenience init(tasks: [Task]) {
		self.init()
		self.taskList = tasks
	}

	/// Возвращает список всех задач.
	/// - Returns: [Task]
	public func allTasks() -> [Task] {
		return taskList
	}

	/// Возвращает список завершенных задач.
	/// - Returns: [Task]
	public func completedTasks() -> [Task] {
		return taskList.filter { $0.isCompleted }
	}

	/// Возвращает список не завершенных задач.
	/// - Returns: [Task]
	public func uncompletedTasks() -> [Task] {
		return taskList.filter { !$0.isCompleted }
	}

	/// Добавляет новую задачу к списку задач.
	/// - Parameter task: Task
	public func addTask(task: Task) {
		taskList.append(task)
	}

	/// Добавляет список задач.
	/// - Parameter task: Task
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}

	/// Удаляет задачу из списка задач.
	/// - Parameter task: Task
	public func delTask (task: Task) {
		taskList.removeAll { $0.title == task.title }
	}
}
