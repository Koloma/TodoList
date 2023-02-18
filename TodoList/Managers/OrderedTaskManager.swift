//
//  OrderedTaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation


final class OrderedTaskManager: ITaskManager {
	let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	func allTasks() -> [ITask] {
		return sorted(tasks: taskManager.allTasks())
	}

	func completedTasks() -> [ITask] {
		return sorted(tasks: taskManager.completedTasks())
	}

	func notCompletedTasks() -> [ITask] {
		return sorted(tasks: taskManager.notCompletedTasks())
	}

	func addTask(task: ITask) {
		taskManager.addTask(task: task)
	}

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
