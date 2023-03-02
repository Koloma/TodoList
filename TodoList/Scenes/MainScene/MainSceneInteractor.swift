//
//  MainSceneInteractor.swift
//  TodoList
//
//  Created by Коломенский Александр on 02.03.2023.
//

import Foundation

protocol IMainSceneDataStore{
	var email: String? { get set }
	var password: String? { get set }
	var success: Bool { get set }
	var login: String { get set }
	var lastLoginDate: Date { get set }
}

protocol IMainSceneInteractor {
	func didTaskSelected(request: MainSceneModel.Request)
}

class MainSceneInteractor: IMainSceneInteractor {
	private var worker: IMainSceneWorker
	private var presenter: IMainScenePresenter?


	init(worker: IMainSceneWorker, presenter: IMainScenePresenter?) {
		self.worker = worker
		self.presenter = presenter
	}


	func didTaskSelected(request: MainSceneModel.Request) {

		let result = worker.setComplete(forIndexPath: request.selectedTask)

		let response = MainSceneModel.Response(
			tasks: result.tasks
		)

		presenter?.present(responce: response)
	}
}
