//
//  IMainScreenView.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

/// Протокол для MainScreen View.
protocol IMainScreenView: AnyObject {
	/// Отобразить данные во View.
	func render(viewData: ViewData)
}
