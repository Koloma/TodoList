//
//  ITaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//


/// Протокол менеджеров управления задачами
protocol ITaskManager {

	/// Возвращает все задачи
	/// - Returns: список задач
	func allTasks() -> [ITask]

	/// Возвращает все выполненные задачи
	/// - Returns: список задач
	func completedTasks() -> [ITask]

	/// Возвращает все невыполненные задачи
	/// - Returns: список задач
	func notCompletedTasks() -> [ITask]

	/// Добавляет задачу в список задач
	/// - Parameter task: новая задача
	func addTask(task: ITask)

	/// Удаляет задачу из списка задач
	/// - Parameter task: удаляемая задача
	func delTask(task: ITask)
}
