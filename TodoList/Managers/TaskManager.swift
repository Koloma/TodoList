//
//  TaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

protocol ITaskManager {
	func allTasks() -> [ITask]
	func completedTasks() -> [ITask]
	func notCompletedTasks() -> [ITask]
	func addTask(task: ITask)
	func delTask (task: ITask)
}

///Менеджер по управлению списком задач
final class TaskManager: ITaskManager {

	private var tasks:[ITask] = []

	init(tasks: [ITask]) {
		self.tasks = tasks
	}

	///Возвращает список всех задач
	func allTasks() -> [ITask] {
		return tasks
	}

	///Возвращает список завершенных задач
	func completedTasks() -> [ITask] {
		return tasks.filter { $0.completed }
	}

	///Возвращает список не завершенных задач
	func notCompletedTasks() -> [ITask] {
		return tasks.filter { !$0.completed }
	}

	///Добавляет новую задачу к списку задач
	func addTask(task: ITask) {
		tasks.append(task)
	}

	//Удаляет задачу из списка задач
	func delTask (task: ITask) {
		tasks.removeAll { $0.title == task.title }
	}
}

extension TaskManager {

	///Возвращает список задач заглушек для демонстрации
	static func CreateMockTaskList() -> [ITask] {
		let task = RegularTask(title: "RegTask 2")
			task.setCompleted(true)
		return  [ RegularTask(title: "RegTask 1")
				  ,ImportantTask(
					title: "ImportantTask 1"
					, taskPriority: .low
					, date: Date(timeIntervalSinceNow: -1000000)
				  )
				  ,task
				  ,RegularTask(title: "RegTask 3")
				  ,ImportantTask(title: "ImportantTask 2", taskPriority: .high)
				  ,ImportantTask(title: "ImportantTask 2", taskPriority: .medium)
		]
	}
}

