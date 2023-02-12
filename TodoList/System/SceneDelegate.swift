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
		let taskList = TaskManager.CreateMockTaskList()
		let viewController = MainScreenViewController(
			mainScreenViewModel: MainScreenViewModel(taskList: taskList)
		)
		window.rootViewController = viewController
		self.window = window
		window.makeKeyAndVisible()

	}

}

