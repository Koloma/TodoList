//
//  MainScreenPresenter.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

/// Протокол для MainScreen Presenter.
protocol IMainScenePresenter {
	/// флаг готовности view для отображения данных
	func viewIsReady()
	/// событие выбора ячейки
	func didTaskSelected(at indexPath: IndexPath)
}

/// MainScreen Presenter.
final class MainScenePresenter: IMainScenePresenter {
	private var sectionManager: ISectionForTaskManagerAdapter!
	private weak var view: IMainSceneViewController!

	init(view: IMainSceneViewController, sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
		self.view = view
	}

	func viewIsReady() {
		view?.render(viewData: mapViewData())
	}

	func didTaskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]

		task.setCompleted(!task.isCompleted)
		view.render(viewData: mapViewData())
	}

	private func mapViewData() -> MainSceneModel.ViewData {
		var sections = [MainSceneModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = MainSceneModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section) )
			)

			sections.append(sectionData)
		}

		return MainSceneModel.ViewData(tasksBySections: sections)
	}

	private func mapTasksData(tasks: [Task]) -> [MainSceneModel.ViewData.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}

	private func mapTaskData(task: Task) -> MainSceneModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = MainSceneModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.isCompleted,
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(MainSceneModel.ViewData.RegularTask(name: task.title, isDone: task.isCompleted))
		}
	}

}
