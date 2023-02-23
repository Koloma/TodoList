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

	private func mapViewData() -> MainModel.ViewData {
		var sections = [MainModel.ViewData.Section]()
		for section in sectionManager.getSections() {
			let sectionData = MainModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section) )
			)

			sections.append(sectionData)
		}

		return MainModel.ViewData(tasksBySections: sections)
	}

	private func mapTasksData(tasks: [Task]) -> [MainModel.ViewData.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}

	private func mapTaskData(task: Task) -> MainModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = MainModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.isCompleted,
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(MainModel.ViewData.RegularTask(name: task.title, isDone: task.isCompleted))
		}
	}

}
