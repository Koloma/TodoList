//
//  TaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

final class TaskManager {

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
	static func CreateMockTaskList() -> [Task] {
		return  [ RegularTask(title: "RegTask 1")
				  ,ImportantTask(title: "ImportantTask 1", taskPriority: .low)
				  ,RegularTask(title: "RegTask 2")
				  ,RegularTask(title: "RegTask 3")
				  ,ImportantTask(title: "ImportantTask 2", taskPriority: .high)
				  ,ImportantTask(title: "ImportantTask 2", taskPriority: .medium)
		]
	}
}

