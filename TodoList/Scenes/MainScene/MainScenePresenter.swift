//
//  MainScreenPresenter.swift
//  TodoList
//
//  Created by Коломенский Александр on 18.02.2023.
//

import Foundation

/// Протокол для MainScreen Presenter.
protocol IMainScenePresenter {
	func present(responce: MainSceneModel.Response)
}

/// MainScreen Presenter.
final class MainScenePresenter: IMainScenePresenter {
	private var sectionManager: ISectionForTaskManagerAdapter!
	private weak var view: IMainSceneViewController!

	init(view: IMainSceneViewController, sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
		self.view = view
	}

	func present(responce: MainSceneModel.Response) {
		view.render(viewData: mapViewData())
	}

	private func mapViewData() -> MainSceneModel.ViewModel {
		var sections = [MainSceneModel.ViewModel.Section]()
		for section in sectionManager.getSections() {
			let sectionData = MainSceneModel.ViewModel.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section) )
			)
			sections.append(sectionData)
		}

		return MainSceneModel.ViewModel(tasksBySections: sections)
	}

	private func mapTasksData(tasks: [Task]) -> [MainSceneModel.ViewModel.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}

	private func mapTaskData(task: Task) -> MainSceneModel.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = MainSceneModel.ViewModel.ImportantTask(
				name: task.title,
				isDone: task.isCompleted,
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(MainSceneModel.ViewModel.RegularTask(name: task.title, isDone: task.isCompleted))
		}
	}

}
