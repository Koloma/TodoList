//
//  MainScreenViewController.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

	private let tableView: UITableView = UITableView()

	var presenter: IMainScreenPresenter!

	
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

// MARK: extension MainScreenViewController: IMainScreenView
extension MainScreenViewController: IMainScreenView {
	func render(viewData: ViewData) {
		tableView.reloadData()
	}
}

// MARK: extension MainScreenViewController
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.viewData.sectionsItems[section].count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let defaultHeightForRow = 80.0
		switch presenter.viewData.sectionsItems[indexPath.section][indexPath.row] {
		case is RegularTask:
			return RegularTaskTableViewCell.cellHeight
		case is ImportantTask:
			return ImportantTaskTableViewCell.cellHeight
		default :
			return defaultHeightForRow
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		presenter.viewData.sectionsItems.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return presenter.viewData.sectionsTitles[section]
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch presenter.viewData.sectionsItems[indexPath.section][indexPath.row] {
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
								self?.presenter.refresh()
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
								self?.presenter.refresh()
							}
						}
				)
				return cell
		default:
			return UITableViewCell()
		}

	}

}

