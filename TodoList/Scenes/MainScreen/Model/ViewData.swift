//
//  ViewData.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

/// Структура для передачи данных во View.
struct ViewData {
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
	enum Section: CaseIterable {

		case completed([Task])
		case uncompleted([Task])

		/// Заголовки секций
		var title: String {
			switch self {
			case .completed:
				return "Completed"
			case .uncompleted:
				return "Uncompleted"
			}
		}
	}

	let tasksBySections: [Section]
}
