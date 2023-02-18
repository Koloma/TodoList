//
//  SceneDelegate.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)

		let taskList = TaskRepositoryStub().loadTasks()
		let taskManager = OrderedTaskManager(taskManager: TaskManager(tasks: taskList))
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		let viewController = MainScreenViewController(
			sectionForTaskManager: sectionForTaskManagerAdapter
		)
		window.rootViewController = viewController
		
		self.window = window
		window.makeKeyAndVisible()

	}

}

