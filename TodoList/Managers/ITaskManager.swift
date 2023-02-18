//
//  ITaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//


/// Протокол менеджеров управления задачами
protocol ITaskManager {
	func allTasks() -> [ITask]
	func completedTasks() -> [ITask]
	func notCompletedTasks() -> [ITask]
	func addTask(task: ITask)
	func delTask(task: ITask)
}
