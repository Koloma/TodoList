//
//  MainSceneRouter.swift
//  TodoList
//
//  Created by Коломенский Александр on 02.03.2023.
//

import UIKit

@objc protocol IMainSceneRouter
{
	func routeToLoginScene()
}

protocol IMainSceneDataStorePassing
{
	var dataStore: IMainSceneDataStore? { get }
}

class MainSceneRouter: NSObject, IMainSceneRouter, IMainSceneDataStorePassing
{
	weak var viewController: MainSceneViewController?
	var dataStore: IMainSceneDataStore? = nil

	init(viewController: MainSceneViewController?) {
		self.viewController = viewController
	}

	func routeToLoginScene()
	{
		let destinationVC = assemblyMainScreen
		//var destinationDS = destinationVC.router!.dataStore!
		//passDataToSomewhere(source: dataStore!, destination: &destinationDS)
		//navigateToSomewhere(source: viewController, destination: destinationVC)
	}

	// MARK: Navigation
	func navigateToSomewhere(source: LoginSceneViewController, destination: MainSceneViewController)
	{
	  source.show(destination, sender: nil)
	}

	// MARK: Passing data
//	func passDataToSomewhere(source: LoginSceneDataStore, destination: inout MainSceneDataStore)
//	{
//	  destination.name = source.name
//	}

	private func assemblyMainScreen() -> UIViewController {
		let viewController = MainSceneViewController()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)

		return viewController
	}
}
