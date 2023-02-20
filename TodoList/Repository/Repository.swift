//
//  Repository.swift
//  TodoList
//
//  Created by Коломенский Александр on 15.02.2023.
//

import Foundation

/// Протокол для загрузки данных из хранилища.
protocol IRepository {
	func loadTasks() -> [Task]
}

/// Stub repository.
final class TaskRepositoryStub: IRepository {

	/// Загружаем заранее подготовленный список задач.
	/// - Returns: [ITask] список задач
	func loadTasks() -> [Task] {
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
