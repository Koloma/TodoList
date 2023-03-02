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

		window.rootViewController = assemblyLoginScreen()
		
		self.window = window
		window.makeKeyAndVisible()
	}


	private func assemblyLoginScreen() -> LoginSceneViewController {

		let viewController = LoginSceneViewController()
		let worker = LoginWorker()
		let presenter = LoginScenePresenter(viewController: viewController)
		let interactor = LoginSceneInteractor(worker: worker, presenter: presenter)
		let router = LoginSceneRouter(viewController: viewController)

		viewController.router = router

		router.viewController = viewController

		return viewController
	}

}

