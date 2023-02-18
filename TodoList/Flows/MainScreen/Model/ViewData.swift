//
//  ViewData.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

/// Структура для передачи данных во View.
struct ViewData {
	/// Список заголовков для секций таблицы.
	let sectionsTitles: [String]

	/// Массив задач разбитый по секциям.
	let sectionsItems: [[ITask]]
}
