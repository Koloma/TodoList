//
//  MainScreenPresenter.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

/// Протокол для MainScreen Presenter.
protocol IMainScreenPresenter: AnyObject {
	/// View
	var view: IMainScreenView? { get }
	/// Model
	var viewData: ViewData { get set }
	/// Инициализатор Presenter
	init(view: IMainScreenView, viewData: ViewData)
	/// Функция для обновления отображаемых данных во View.
	func refresh()
}

/// MainScreen Presenter.
final class MainScreenPresenter: IMainScreenPresenter {
	/// Ссылка на MainScreen View.
	weak var view: IMainScreenView?
	/// Данные для отображения во View.
	var viewData: ViewData

	/// Инициализатор Presenter.
	init(view: IMainScreenView, viewData: ViewData) {
		self.view = view
		self.viewData = viewData
	}

	/// Функция для обновления отображаемых данных во View.
	func refresh() {
		view?.render(viewData: viewData)
	}
}


