//
//  MainScreenPresenter.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

protocol IMainScreenPresenter: AnyObject {
	var view: IMainScreenView? { get }
	var viewData: ViewData { get set }
	init(view: IMainScreenView, viewData: ViewData)
	func refresh()
}

final class MainScreenPresenter: IMainScreenPresenter {
	weak var view: IMainScreenView?
	var viewData: ViewData

	init(view: IMainScreenView, viewData: ViewData) {
		self.view = view
		self.viewData = viewData
	}

	func refresh() {
		view?.render(viewData: viewData)
	}
}


