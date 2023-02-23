//
//  ITaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//


/// Протокол менеджеров управления задачами.
protocol ITaskManager {

	/// Возвращает все задачи.
	/// - Returns: список задач
	func allTasks() -> [Task]

	/// Возвращает все выполненные задачи.
	/// - Returns: список задач
	func completedTasks() -> [Task]

	/// Возвращает все невыполненные задачи.
	/// - Returns: список задач
	func uncompletedTasks() -> [Task]

	/// Добавляет задачу в список задач.
	/// - Parameter task: новая задача
	func addTask(task: Task)

	/// Удаляет задачу из списка задач.
	/// - Parameter task: удаляемая задача
	func delTask(task: Task)

	/// Добавляет список задач.
	/// - Parameter task: Task
	func addTasks(tasks: [Task])
}
