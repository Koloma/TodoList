//
//  IMainScreenView.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation


protocol IMainScreenView: AnyObject {
	func render(viewData: ViewData)
}
