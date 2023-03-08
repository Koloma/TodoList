//
//  MainSceneInteractor.swift
//  TodoList
//
//  Created by Коломенский Александр on 02.03.2023.
//

import Foundation

protocol IMainSceneDataStore {
	var email: String? { get set }
	var login: String? { get set }
	var lastLoginDate: Date? { get set }
}

protocol IMainSceneInteractor {
	func didTaskSelected(request: MainSceneModel.Request)
	func viewIsReady()
}

class MainSceneInteractor: IMainSceneInteractor, IMainSceneDataStore {
	var email: String?
	var login: String?
	var lastLoginDate: Date?

	private var worker: IMainSceneWorker
	private var presenter: IMainScenePresenter?
	var dataStrore: IMainSceneDataStore?

	init(worker: IMainSceneWorker, presenter: IMainScenePresenter?) {
		self.worker = worker
		self.presenter = presenter
	}

	func viewIsReady() {
		let result = worker.getTasks()

		let response = MainSceneModel.Response(
			tasks: result.tasks
		)

		presenter?.present(response: response)
	}

	func didTaskSelected(request: MainSceneModel.Request) {

		let result = worker.setComplete(taskTitle: request.selectedTaskTitle)

		let response = MainSceneModel.Response(
			tasks: result.tasks
		)

		presenter?.present(response: response)
	}
}
