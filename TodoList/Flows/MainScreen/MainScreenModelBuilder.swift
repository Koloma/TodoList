//
//  MainScreenModelBuilder.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import UIKit

protocol Builder {
	static func createModel() -> UIViewController
}

class MainScreenModelBuilder: Builder {
	static func createModel() -> UIViewController {
		let taskList = TaskRepositoryStub().loadTasks()
		let taskManager = OrderedTaskManager(taskManager: TaskManager(tasks: taskList))
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)

		var sectionsItems = [[ITask]]()
		for index in 0...sectionForTaskManagerAdapter.getSectionsTitles().count - 1 {
			let sectionData = sectionForTaskManagerAdapter.getSectionsItems(section: index)
			sectionsItems.append(sectionData)
		}

		let viewData = ViewData(
			sectionsTitles: sectionForTaskManagerAdapter.getSectionsTitles()
			, sectionsItems: sectionsItems)

		let viewController = MainScreenViewController()
		let presenter = MainScreenPresenter(view: viewController, viewData: viewData)
		viewController.presenter = presenter

		return viewController
	}


}
