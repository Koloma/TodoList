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

	private let segmentedControl: UISegmentedControl = {
		let items = ["All", "Not completed", "Completed"]
		let segmentControl = UISegmentedControl(items: items)
		segmentControl.selectedSegmentIndex = 0
		return segmentControl
	}()

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
		tableView.register(
			RegularTaskTableViewCell.nib
			, forCellReuseIdentifier: RegularTaskTableViewCell.reuseCellID)
		tableView.register(
			ImportantTaskTableViewCell.nib
			, forCellReuseIdentifier: ImportantTaskTableViewCell.reuseCellID)

	}
	private func initView() {
		view.backgroundColor = .systemBackground

		segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
		view.addSubview(segmentedControl)
		segmentedControl.snp.makeConstraints { make in
			make.left.right.equalTo(view)
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)

		}
		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.top.equalTo(segmentedControl.snp.bottom).offset(15)
			make.left.right.bottom.equalTo(view)
		}
	}

	@objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			taskList = taskManager?.allTasks() ?? []
		case 1:
			taskList = taskManager?.notCompletedTasks() ?? []
		case 2:
			taskList = taskManager?.completedTasks() ?? []
		default:
			taskList = []
		}
		tableView.reloadData()
	}
}

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return taskList.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch taskList[indexPath.row] {
		case is RegularTask:
			return RegularTaskTableViewCell.cellHeight
		case is ImportantTask:
			return ImportantTaskTableViewCell.cellHeight
		default :
			return 10
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch taskList[indexPath.row] {
		case let task where task is RegularTask:
			guard let cell = tableView.dequeueReusableCell(
				withIdentifier: RegularTaskTableViewCell.reuseCellID
				, for: indexPath
			) as? RegularTaskTableViewCell
			else { return UITableViewCell()}
				cell.config(
						model: RegularTaskCellModelInput(
						task: task as! RegularTask)
				)
				return cell

		case let task where task is ImportantTask:
			guard let cell = tableView.dequeueReusableCell(
				withIdentifier: ImportantTaskTableViewCell.reuseCellID
				, for: indexPath
			) as? ImportantTaskTableViewCell
			else { return UITableViewCell()}
				cell.config(
						model: ImportantTaskCellModelInput(
						task: task as! ImportantTask)
				)
				return cell
		default:
			return UITableViewCell()
		}

	}

}

