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

final class TaskManager: ITaskManager {

	private var tasks:[ITask] = []

	init(tasks: [ITask]) {
		self.tasks = tasks
	}

	func allTasks() -> [ITask] {
		return tasks
	}

	func completedTasks() -> [ITask] {
		return tasks.filter { $0.completed }
	}

	func notCompletedTasks() -> [ITask] {
		return tasks.filter { !$0.completed }
	}

	func addTask(task: ITask) {
		tasks.append(task)
	}

	func delTask (task: ITask) {
		tasks.removeAll { $0.title == task.title }
	}
}

extension TaskManager {
	static func CreateMockTaskList() -> [ITask] {
		return  [ RegularTask(title: "RegTask 1")
				  ,ImportantTask(
					title: "ImportantTask 1"
					, taskPriority: .low
					, date: Date(timeIntervalSinceNow: -1000000)
				  )
				  ,RegularTask(title: "RegTask 2")
				  ,RegularTask(title: "RegTask 3")
				  ,ImportantTask(title: "ImportantTask 2", taskPriority: .high)
				  ,ImportantTask(title: "ImportantTask 2", taskPriority: .medium)
		]
	}
}

