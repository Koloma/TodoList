//
//  MainViewTaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 15.02.2023.
//

import Foundation


protocol ISectionForTaskManagerAdapter {

	func getSectionsTitles() -> [String]
	func getSectionsItems(section sectionIndex: Int) -> [ITask]
}

final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	func getSectionsTitles() -> [String] {
		return ["Not completed tasks", "Completed tasks"]
	}

	func getSectionsItems(section sectionIndex: Int) -> [ITask] {
		switch sectionIndex {
		case 0:
			return taskManager.notCompletedTasks()
		default:
			return taskManager.completedTasks()
		}
	}
}
