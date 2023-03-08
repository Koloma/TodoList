//
//  Task.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import Foundation

/// Базовый класс задач.
class Task {

	/// Дата создания задачи.
	private(set) var createDate: Date
	/// Статус выполнения задачи.
	private(set) var isCompleted: Bool
	/// Заголовок задачи.
	private(set) var title: String

	/// Инициализатор базовой задачи.
	/// - Parameters:
	///   - title: заголовок задачи
	///   - date: дата начала задачи
	init(title: String, completed: Bool = false, date: Date? = nil) {
		self.title = title
		self.isCompleted = false
		self.createDate = date ?? Date()
	}

	/// Устанавливает статус задачи в состояние выполненной или нет,
	/// зависит от значения передаваемого параметра.
	func setCompleted(_ state: Bool) {
		self.isCompleted = state
	}
}

/// Обычные задач.
final class RegularTask: Task { }

/// Важные задачи содержат приоритет и дату окончания.
final class ImportantTask: Task {

	/// Приоритеты задач.
	enum TaskPriority: Int {
		case low
		case medium
		case high
	}

	/// Сроки в сутках для приоритетных задач.
	enum TaskPriorityDayCount: Int {
		case low = 3
		case medium = 2
		case high = 1
	}

	/// Приоритет задач.
	private(set) var taskPriority: TaskPriority

	/// Дата окончания задания (зависит от приоритета).
	var deadLine: Date {
		switch taskPriority {
		case .low:
			if let date = Calendar.current.date(
				byAdding: .day,
				value: TaskPriorityDayCount.low.rawValue,
				to: createDate
			) {
				return date
			} else {
				return Date()
			}
		case .medium:
			if let date = Calendar.current.date(
				byAdding: .day,
				value: TaskPriorityDayCount.medium.rawValue,
				to: createDate
			) {
				return date
			} else {
				return Date()
			}
		case .high:
			if let date = Calendar.current.date(
				byAdding: .day,
				value: TaskPriorityDayCount.high.rawValue,
				to: createDate
			) {
				return date
			} else {
				return Date()
			}
		}
	}

	/// Инициализатор важных задач.
	/// - Parameters:
	///   - title: заголовок задачи
	///   - taskPriority: приоритет задачи
	///   - date: дата начала задачи
	init(title: String, taskPriority: TaskPriority, date: Date? = nil) {
		self.taskPriority = taskPriority
		super.init(title: title, date: date)
	}
}

// MARK: extension RegularTask
extension RegularTask {

	/// Строковое описание для обычных задач.
	var description: String {
		return "[\(isCompleted ? "X" : " ")] RegularTask \(title)"
	}
}

// MARK: extension ImportantTask
extension ImportantTask {

	/// Строковое описание для важных задач.
	var description: String {
		return "[\(isCompleted ? "X" : " ")] ImportantTask \(title) Priority \(taskPriority)"
	}
}

// MARK: extension ImportantTask.TaskPriority
extension ImportantTask.TaskPriority: CustomStringConvertible {
	var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
