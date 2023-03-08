//
//  ViewData.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

enum MainSceneModel {

	struct Request {
		var selectedTaskTitle: String
	}

	struct Response {
		var tasks: [Task]
	}

	struct ViewModel {
		/// Данные для отображения RegularTask
		struct RegularTask {
			let name: String
			let isDone: Bool
		}

		/// Данные для отображения ImportantTask
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadLine: String
			let priority: String
		}

		/// Данные для отображения Task
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}

		/// Данные для отображения секций таблицы
		struct Section {
			let title: String
			let tasks: [Task]
		}

		let tasksBySections: [Section]
	}
}
