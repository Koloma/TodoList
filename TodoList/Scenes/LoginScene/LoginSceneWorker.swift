//
//  LoginSceneWorker.swift
//  TodoList
//
//  Created by Коломенский Александр on 23.02.2023.
//  Copyright (c) 2023 KAV. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// Структура LoginDTO
public struct LoginDTO {

	/// Флаг успешной авторизации.
	var success: Bool

	/// Логин
	var login: String

	/// Время последней удачной авторизации.
	var lastLoginDate: Date
}


/// Интерфейс ILoginWorker.
protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

/// Worker отвечающий за авторизацию пользователя
/// проверку логина и пароля.
final class LoginWorker: ILoginWorker {

	/// Выполняет проверку введенных логина и пароля.
	/// - Parameters:
	///   - login: Логин пользователя
	///   - password: Пароль пользователя
	/// - Returns: возвращает структуру LoginDTO
	func login(login: String, password: String) -> LoginDTO {

		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)



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

}
