//
//  Repository.swift
//  TodoList
//
//  Created by Коломенский Александр on 15.02.2023.
//

import Foundation

/// Протокол для загрузки данных из хранилища.
protocol ITaskRepository {
	func getTasks() -> [Task]
}

/// Stub repository.
final class TaskRepositoryStub: ITaskRepository {

	/// Загружаем заранее подготовленный список задач.
	/// - Returns: [ITask] список задач
	func getTasks() -> [Task] {
		let task = RegularTask(title: "RegTask 2")
		task.setCompleted(true)
		let importantTask = ImportantTask(
			title: "ImportantTask 1",
			taskPriority: .low,
			date: Date(timeIntervalSinceNow: -1000000)
		)
		return [
			RegularTask(title: "RegTask 1"),
			importantTask,
			task,
			RegularTask(title: "RegTask 3"),
			ImportantTask(title: "ImportantTask 2", taskPriority: .high),
			ImportantTask(title: "ImportantTask 2", taskPriority: .medium)
		]
	}
}
