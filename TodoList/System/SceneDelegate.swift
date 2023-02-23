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

		window.rootViewController = assembly()
		
		self.window = window
		window.makeKeyAndVisible()

	}

	private func assembly() -> UIViewController {

		//let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

//		guard let viewController = storyboard.instantiateViewController(withIdentifier: "MainScreenViewController")
//				as? MainScreenViewController
//		else {
//			fatalError("Нету на Main.storyboard MainScreenViewController!")
//		}

		let viewController = MainSceneViewController()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)

		let presenter = MainScenePresenter(view: viewController, sectionManager: sections)
		viewController.presenter = presenter

		return viewController
	}
}

