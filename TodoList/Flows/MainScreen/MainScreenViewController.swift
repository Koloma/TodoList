//
//  MainScreenViewController.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {

	private let tableView: UITableView = UITableView()
	private var taskManager: ITaskManager? = nil
	private var taskList: [ITask] = []

	init(taskManager: ITaskManager) {

		self.taskManager = taskManager
		self.taskList = taskManager.allTasks()

		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	// MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		initView()
		initTableView()
	}

	private func initTableView() {
		tableView.dataSource = self
		tableView.rowHeight = 80.0

		tableView.register(
			RegularTaskTableViewCell.nib
			, forCellReuseIdentifier: RegularTaskTableViewCell.reuseCellID)
		tableView.register(
			ImportantTaskTableViewCell.nib
			, forCellReuseIdentifier: ImportantTaskTableViewCell.reuseCellID)

	}
	private func initView() {

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		tableView.backgroundColor = .blue
	}
}

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return taskList.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch taskList[indexPath.row] {
		case is RegularTask:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: RegularTaskTableViewCell.reuseCellID
				, for: indexPath
			) as? RegularTaskTableViewCell
				, let task = taskList[indexPath.row] as? RegularTask {
				cell.config(
					regularTaskCellModel: RegularTaskCellModelInput(
						task: task)
				)
				return cell
			}
			else {
				return UITableViewCell()
			}
		case is ImportantTask:
			if let cell = tableView.dequeueReusableCell(
				withIdentifier: ImportantTaskTableViewCell.reuseCellID
				, for: indexPath
			) as? ImportantTaskTableViewCell
				, let task = taskList[indexPath.row] as? ImportantTask {
				cell.config(
					importantTaskCellModelInput: ImportantTaskCellModelInput(
						task: task)
				)
				return cell
			}
			else {
				return UITableViewCell()
			}
		default:
			print("Uncnown Task")
		}
		return UITableViewCell()
	}

}

