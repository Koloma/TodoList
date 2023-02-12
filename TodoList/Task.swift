//
//  Task.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

protocol ITask {
	var completed: Bool { get }
	var title: String { get }
	func setCompleted(_ state: Bool)
}

class Task: ITask {

	private(set) var completed: Bool
	private(set) var title: String

	init(title: String) {
		self.title = title
		self.completed = false
	}

	func setCompleted(_ state: Bool) {
		self.completed = state
	}
}



final class RegularTask: Task { }


final class ImportantTask: Task {

	enum TaskPriority {
		case low
		case medium
		case high
	}

	enum TaskPriorityDayCount: Int {
		case low = 3
		case medium = 2
		case hight = 1
	}

	private(set) var taskPriority: TaskPriority
	var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(
				byAdding: .day
				,value: TaskPriorityDayCount.low.rawValue
				,to: Date())!
		case .medium:
			return Calendar.current.date(
				byAdding: .day
				,value: TaskPriorityDayCount.medium.rawValue
				,to: Date())!
		case .high:
			return Calendar.current.date(
				byAdding: .day
				,value: TaskPriorityDayCount.hight.rawValue
				,to: Date())!
		}
	}

	init(title: String, taskPriority: TaskPriority) {
		self.taskPriority = taskPriority
		super.init(title: title)
	}
}


extension RegularTask {
	var description: String {
		return "[\(completed ? "X" : " ")] RegularTask \(title)"
	}
}

extension ImportantTask {
	var description: String {
		return "[\(completed ? "X" : " ")] ImportantTask \(title) Priority \(taskPriority)"
	}

}
