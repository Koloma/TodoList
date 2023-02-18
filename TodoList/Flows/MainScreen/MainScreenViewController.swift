//
//  MainScreenViewController.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

	private let tableView: UITableView = UITableView()
	private var sectionForTaskManager: ISectionForTaskManagerAdapter

	// MARK: init
	init(sectionForTaskManager: ISectionForTaskManagerAdapter) {
		self.sectionForTaskManager = sectionForTaskManager
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		initView()
		initTableView()
	}

	// MARK: initViewTableView
	private func initTableView() {
		tableView.dataSource = self
		tableView.register(
			RegularTaskTableViewCell.nib
			, forCellReuseIdentifier: RegularTaskTableViewCell.reuseCellID)
		tableView.register(
			ImportantTaskTableViewCell.nib
			, forCellReuseIdentifier: ImportantTaskTableViewCell.reuseCellID)

	}

	// MARK: initView
	private func initView() {

		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
}

// MARK: extension MainScreenViewController
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sectionForTaskManager.getSectionsItems(section: section).count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
			return 80
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		sectionForTaskManager.getSectionsTitles().count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sectionForTaskManager.getSectionsTitles()[section]
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch sectionForTaskManager.getSectionsItems(section: indexPath.section)[indexPath.row] {
		case let task where task is RegularTask:
			guard let cell = tableView.dequeueReusableCell(
				withIdentifier: RegularTaskTableViewCell.reuseCellID
				, for: indexPath
			) as? RegularTaskTableViewCell
			else { return UITableViewCell()}
				cell.config(
						model: RegularTaskCellModelInput(
						task: task as! RegularTask)
						,modelOutput: {[weak self] value in
							task.setCompleted(value)
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
								self?.tableView.reloadData()
							}
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
						,modelOutput: {[weak self] value in
							task.setCompleted(value)
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
								self?.tableView.reloadData()
							}
						}
				)
				return cell
		default:
			return UITableViewCell()
		}

	}

}

