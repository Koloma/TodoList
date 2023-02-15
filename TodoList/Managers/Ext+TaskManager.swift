//
//  Ext+TaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 15.02.2023.
//

import Foundation

extension TaskManager: IMainViewTaskManagerAdapter {

	func getSectionsTitles() -> [String] {
		return ["Not completed tasks", "Completed tasks"]
	}

	func getSectionsItems(section sectionIndex: Int) -> [ITask] {
		switch sectionIndex {
		case 0:
			return mySort(tasks: self.notCompletedTasks())
		case 1:
			return mySort(tasks: self.completedTasks())
		default:
			return [ITask]()
		}
	}

	func mySort(tasks: [ITask]) -> [ITask] {
		var result: [ITask] = []
		result.append(contentsOf: tasks.filter { ($0 as? ImportantTask)?.taskPriority == .high })
		result.append(contentsOf: tasks.filter { ($0 as? ImportantTask)?.taskPriority == .medium })
		result.append(contentsOf: tasks.filter { ($0 as? ImportantTask)?.taskPriority == .low })
		result.append(contentsOf: tasks.filter { $0 is RegularTask })
		return result
	}
}
