//
//  MainScreenViewController.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

	private let tableView: UITableView = UITableView()
	private var taskManager: ITaskManager? = nil
	private var taskList: [ITask] = []
	private var currentTaskListStates: TaskListState = .all {
		didSet {
			tableReloadData()
		}
	}

	private func tableReloadData() {
		switch currentTaskListStates {
		case .all:
			taskList = taskManager?.allTasks() ?? []
		case .notCompleted:
			taskList = taskManager?.notCompletedTasks() ?? []
		case .completed:
			taskList = taskManager?.completedTasks() ?? []
		}
		tableView.reloadData()
	}

	private enum TaskListState: String, CaseIterable {
		case all = "All"
		case notCompleted = "Not completed"
		case completed = "Completed"
	}
	private let segmentedControl: UISegmentedControl = {

		let items = TaskListState.allCases.map { $0.rawValue }
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
//		segmentedControl.snp.makeConstraints { make in
//			make.left.right.equalTo(view)
//			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//
//		}
		view.addSubview(tableView)
//		tableView.snp.makeConstraints { make in
//			make.top.equalTo(segmentedControl.snp.bottom).offset(15)
//			make.left.right.bottom.equalTo(view)
//		}
	}

	@objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			currentTaskListStates = .all
		case 1:
			currentTaskListStates = .notCompleted
		case 2:
			currentTaskListStates = .completed
		default:
			taskList = []
			currentTaskListStates = .all
		}
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
			return 50
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
						,modelOutput: { [weak self] value in
							guard let self = self else { return }
							task.setCompleted(value)
							self.tableReloadData()
						}
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
						,modelOutput: { [weak self] value in
							guard let self = self else { return }
							task.setCompleted(value)
							self.tableReloadData()
						}
				)
				return cell
		default:
			return UITableViewCell()
		}

	}

}

