//
//  MainScreenViewController.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

/// Протокол для MainScreen View.
protocol IMainSceneViewController: AnyObject {
	/// Отобразить данные во View.
	func render(viewData: MainSceneModel.ViewModel)
}

class MainSceneViewController: UIViewController {
	private(set) var router: (NSObjectProtocol & IMainSceneRouter & IMainSceneDataPassing)?
	var interactor: IMainSceneInteractor?

	private let tableView = UITableView()

	var viewData: MainSceneModel.ViewModel = MainSceneModel.ViewModel(tasksBySections: [])
	// MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()

		initView()
		initTableView()
		interactor?.viewIsReady()
	}

	// MARK: initViewTableView
	private func initTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	// MARK: initView
	private func initView() {
		title = "TodoList"
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
}

// MARK: extension MainScreenViewController: IMainViewController
extension MainSceneViewController: IMainSceneViewController {
	func render(viewData: MainSceneModel.ViewModel) {
		self.viewData = viewData
		tableView.reloadData()
	}
}

// MARK: extension MainScreenViewController
extension MainSceneViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewData.tasksBySections[section]
		return section.tasks.count
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySections.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySections[section].title
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		switch taskData {
		case .importantTask(let task):
			let request = MainSceneModel.Request(selectedTaskTitle: task.name)
			interactor?.didTaskSelected(request: request)
		case .regularTask(let task):
			let request = MainSceneModel.Request(selectedTaskTitle: task.name)
			interactor?.didTaskSelected(request: request)
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tasks = viewData.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		var contentConfiguration = cell.defaultContentConfiguration()

		switch taskData {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText )
			taskText.append(NSAttributedString(string: task.name))

			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverdue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		}

		cell.tintColor = .red
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration

		return cell
	}
}
