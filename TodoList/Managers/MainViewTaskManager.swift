//
//  MainViewTaskManager.swift
//  TodoList
//
//  Created by Коломенский Александр on 15.02.2023.
//

import Foundation


protocol IMainViewTaskManagerAdapter: ITaskManager {

	func getSectionsTitles() -> [String]
	func getSectionsItems(section sectionIndex: Int) -> [ITask]
}
