//
//  MainScreenModelBuilder.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import UIKit

/// Протокол для сборки модуля MVP.
protocol UnitBuilder {

	/// Строитель модуля MVP .
	/// - Returns: UIViewController
	static func createVMPUnit() -> UIViewController
}

/// Строитель модуля MVP для MainScreen.
class MainScreenUnitBuilder: UnitBuilder {
	/// Функция создающая модуль MVP со всеми зависимостями для MainScreen.
	/// - Returns: возвращает полностью настроенный UIViewController
	static func createVMPUnit() -> UIViewController {
		let taskList = TaskRepositoryStub().loadTasks()
		let taskManager = OrderedTaskManager(taskManager: TaskManager(tasks: taskList))
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)

		var sectionsItems = [[Task]]()
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
