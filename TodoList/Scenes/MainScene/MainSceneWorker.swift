//
//  MainSceneWorker.swift
//  TodoList
//
//  Created by Коломенский Александр on 02.03.2023.
//

import Foundation

/// Структура LoginDTO
public struct MainDTO {
	var tasks: [Task]
}


/// Интерфейс ILoginWorker.
protocol IMainSceneWorker {
	func setComplete(forIndexPath: IndexPath) -> MainDTO
	func getTasks() -> MainDTO
}

/// Worker отвечающий за авторизацию пользователя
/// проверку логина и пароля.
final class MainSceneWorker: IMainSceneWorker {

	let taskRepository: ITaskRepository
	let sectionManager: ISectionForTaskManagerAdapter
	let taskManager: ITaskManager
	var tasks: [Task] = []

	init() {
		taskRepository = TaskRepositoryStub()
		let tmpTaskManager = TaskManager(tasks: taskRepository.getTasks())
		taskManager = OrderedTaskManager(taskManager: tmpTaskManager)
		sectionManager = SectionForTaskManagerAdapter(taskManager: taskManager)
	}

	func login(login: String, password: String) -> LoginDTO {

		if login == "kav@ya.ru" && password == "123" {
			return LoginDTO(
				success: true,
				login: login,
				lastLoginDate: Date()
			)
		} else {
			return LoginDTO(
				success: false,
				login: login,
				lastLoginDate: Date()
			)
		}
	}

	func getTasks() -> MainDTO {
		return MainDTO(tasks: tasks)
	}

	func setComplete(forIndexPath: IndexPath) -> MainDTO {

		let section = sectionManager.getSection(forIndex: forIndexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[forIndexPath.row]

		task.setCompleted(!task.isCompleted)

		return MainDTO(tasks: tasks)

	}

}
