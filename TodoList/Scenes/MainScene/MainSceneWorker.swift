//
//  MainSceneWorker.swift
//  TodoList
//
//  Created by Коломенский Александр on 02.03.2023.
//

import Foundation

/// Структура MainDTO
public struct MainDTO {
	var tasks: [Task]
}

/// Интерфейс ILoginWorker.
protocol IMainSceneWorker {
	func setComplete(taskTitle: String) -> MainDTO
	func getTasks() -> MainDTO
}

/// Worker отвечающий за авторизацию пользователя
/// проверку логина и пароля.
final class MainSceneWorker: IMainSceneWorker {

	let taskRepository: ITaskRepository
	var tasks: [Task] = []

	init() {
		taskRepository = TaskRepositoryStub()
		tasks = taskRepository.getTasks()
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

	func setComplete(taskTitle: String) -> MainDTO {

		if let task = tasks.first(where: { $0.title == taskTitle }) {
			task.setCompleted(!task.isCompleted)
		}

		return MainDTO(tasks: tasks)
	}
}
