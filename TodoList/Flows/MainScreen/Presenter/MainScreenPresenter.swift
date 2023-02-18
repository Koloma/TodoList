//
//  MainScreenPresenter.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

protocol IMainScreenPresenter: AnyObject {
	var view: IMainScreenView { get }
	var viewData: ViewData { get }
	init(view: IMainScreenView, viewData: ViewData)
}

final class MainScreenPresenter: IMainScreenPresenter {
	let view: IMainScreenView
	let viewData: ViewData

	init(view: IMainScreenView, viewData: ViewData) {
		self.view = view
		self.viewData = viewData
	}
	
}


