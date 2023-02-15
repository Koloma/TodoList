//
//  Task.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

/// Протокол задач
protocol ITask {
	var createDate: Date { get }
	var completed: Bool { get }
	var title: String { get }
	func setCompleted(_ state: Bool)
}

/// Базовый класс задач
class Task: ITask {

	private(set) var createDate: Date
	private(set) var completed: Bool
	private(set) var title: String

	/// Инициализатор базовой задачи
	/// - Parameters:
	///   - title: заголовок задачи
	///   - date: дата начала задачи
	init(title: String, date: Date? = nil) {
		self.title = title
		self.completed = false
		self.createDate = date ?? Date()
	}

	func setCompleted(_ state: Bool) {
		self.completed = state
	}
}


/// Обычные задач
final class RegularTask: Task { }


/// Важные задачи
/// содержат приоритет и дату окончания
final class ImportantTask: Task {

	/// Приоритеты задач
	enum TaskPriority {
		case low
		case medium
		case high
	}

	/// Сроки в сутках для приоритетных задач
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
				,to: createDate)!
		case .medium:
			return Calendar.current.date(
				byAdding: .day
				,value: TaskPriorityDayCount.medium.rawValue
				,to: createDate)!
		case .high:
			return Calendar.current.date(
				byAdding: .day
				,value: TaskPriorityDayCount.hight.rawValue
				,to: createDate)!
		}
	}


	/// Инициализатор важных задач
	/// - Parameters:
	///   - title: заголовок задачи
	///   - taskPriority: приоритет задачи
	///   - date: дата начала задачи
	init(title: String, taskPriority: TaskPriority, date: Date? = nil) {
		self.taskPriority = taskPriority
		super.init(title: title, date: date)
	}
}

/// Строковое описание для обычных задач
extension RegularTask {
	var description: String {
		return "[\(completed ? "X" : " ")] RegularTask \(title)"
	}
}

/// Строковое описание для важных задач
extension ImportantTask {
	var description: String {
		return "[\(completed ? "X" : " ")] ImportantTask \(title) Priority \(taskPriority)"
	}

}
